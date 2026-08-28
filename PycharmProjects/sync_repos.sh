#!/bin/bash

# This script downloads all repositories from a Bitbucket Server instance.
# It uses the BITBUCKET_APIKEY environment variable for authentication.
# Repositories are cloned into directories named after their project keys.
# Requirements: curl, jq

# Configuration
BITBUCKET_URL="https://git.maxpool.ir"

# Check if BITBUCKET_APIKEY is set (never hardcode the token here)
if [ -z "$BITBUCKET_APIKEY" ]; then
  echo "Error: BITBUCKET_APIKEY environment variable is not set." >&2
  echo "Set it in ~/.config/fish/local.fish (fish) or your shell profile:" >&2
  echo "  set -gx BITBUCKET_APIKEY '<bitbucket-http-access-token>'" >&2
  exit 1
fi

AUTH_HEADER="Authorization: Bearer $BITBUCKET_APIKEY"

# Function to fetch all items with pagination
fetch_all_items() {
  local url="$1"
  local items_json=""
  local is_last_page="false"
  local start=0

  while [ "$is_last_page" != "true" ]; do
    response=$(curl -s -H "$AUTH_HEADER" "$url&start=$start")
    if [ $? -ne 0 ]; then
      echo "Error: Failed to fetch data from $url"
      exit 1
    fi
    items_json+=$(echo "$response" | jq -c '.values[]')
    items_json+=$'\n'
    is_last_page=$(echo "$response" | jq -r '.isLastPage')
    if [ "$is_last_page" != "true" ]; then
      start=$(echo "$response" | jq -r '.nextPageStart')
    fi
  done

  echo "$items_json"
}

# Fetch all projects
echo "Fetching projects..."
projects_url="$BITBUCKET_URL/rest/api/1.0/projects?limit=1000"
projects=$(fetch_all_items "$projects_url")

# Loop through each project
echo "$projects" | while read -r project; do
  project_key=$(echo "$project" | jq -r '.key')
  echo "Processing project: $project_key"

  # Create a directory for the project
  mkdir -p "$project_key"
  cd "$project_key" || exit 1

  # Fetch all repositories for the project
  echo "Fetching repositories for project $project_key..."
  repos_url="$BITBUCKET_URL/rest/api/1.0/projects/$project_key/repos?limit=1000"
  repos=$(fetch_all_items "$repos_url")

  # Loop through each repository
  echo "$repos" | while read -r repo; do
    repo_slug=$(echo "$repo" | jq -r '.slug')
    echo "Processing repository: $repo_slug"

    # Get the clone URL (HTTP)
    clone_url=$(echo "$repo" | jq -r '.links.clone[] | select(.name=="ssh") | .href')

    # Modify the clone URL to include authentication
    clone_url_with_auth=$(echo "$clone_url" | sed "s#https://#https://x-token-auth:$BITBUCKET_APIKEY@#")

    # Check if the repository directory already exists
    if [ -d "$repo_slug" ]; then
      # echo "Repository $repo_slug already exists. Fetching updates..."
      cd "$repo_slug" || exit 1
      git fetch --all
      if [ $? -ne 0 ]; then
        echo "Error: Failed to fetch updates for repository $repo_slug"
      else
        # Advance the checked-out branch too, so working trees (and the
        # CodeGraph indexes built from them below) don't go stale.
        # ff-only merge: never creates merge commits, never rewrites
        # history — a diverged branch is reported and left untouched.
        # Skipped when tracked files are modified (-uno: untracked files
        # alone don't block; git itself aborts the merge if one would be
        # overwritten) or when HEAD is detached / has no upstream.
        if [ -z "$(git status --porcelain -uno)" ] \
          && git symbolic-ref -q HEAD >/dev/null \
          && git rev-parse -q --verify '@{u}' >/dev/null 2>&1; then
          if ! git merge --ff-only '@{u}' >/dev/null 2>&1; then
            echo "note: $repo_slug — current branch diverged from upstream, left untouched"
          fi
        else
          echo "note: $repo_slug — dirty/detached/no-upstream, working tree not advanced"
        fi
      fi
      cd ..
    else
      # Clone the repository
      echo "Cloning repository: $repo_slug"
      git clone "$clone_url_with_auth" "$repo_slug"
      if [ $? -ne 0 ]; then
        echo "Error: Failed to clone repository $repo_slug"
      fi
    fi
  done

  # Return to the parent directory
  cd ..

done

echo "All repositories have been processed."

# ---------------------------------------------------------------------------
# Regenerate PROJECT_INDEX.md from actual filesystem state (no hand editing).
# Active groups get full stack-sniff tables; MD/EXTRA/OLD/ER marked inactive.
# ---------------------------------------------------------------------------
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INDEX_FILE="$ROOT_DIR/PROJECT_INDEX.md"
ACTIVE_GROUPS=(EB EF COM BC DEV AI CMDB)
INACTIVE_GROUPS=(MD EXTRA OLD ER)

# ---------------------------------------------------------------------------
# CodeGraph index maintenance — active groups only (OLD/EXTRA/MD/ER excluded
# on purpose, see PROJECT_INDEX.md inactive-groups section). init builds a
# missing index, sync refreshes an existing one incrementally. Best-effort:
# an index failure never fails the repo sync.
# ---------------------------------------------------------------------------
if command -v codegraph >/dev/null 2>&1; then
  echo "Maintaining CodeGraph indexes (active groups)..."
  for group in "${ACTIVE_GROUPS[@]}"; do
    [ -d "$ROOT_DIR/$group" ] || continue
    for repo in "$ROOT_DIR/$group"/*/; do
      [ -d "$repo/.git" ] || continue
      repo=${repo%/}
      if [ -d "$repo/.codegraph" ]; then
        (cd "$repo" && codegraph sync . >/dev/null 2>&1) \
          || echo "warn: codegraph sync failed for $repo"
      else
        echo "Indexing (codegraph init): $repo"
        (cd "$repo" && codegraph init . >/dev/null 2>&1) \
          || echo "warn: codegraph init failed for $repo"
      fi
    done
  done
else
  echo "codegraph not on PATH — skipping index maintenance"
fi

sniff_stack() {
  local repo_path="$1"
  if [ -f "$repo_path/pyproject.toml" ] || [ -f "$repo_path/requirements.txt" ]; then
    echo "Python"
  elif [ -f "$repo_path/package.json" ]; then
    echo "Node/TS"
  elif ls "$repo_path"/*.tf >/dev/null 2>&1; then
    echo "Terraform"
  elif [ -d "$repo_path/charts" ] || ls "$repo_path"/*.yaml >/dev/null 2>&1; then
    echo "YAML/Config"
  else
    echo "—"
  fi
}

source_package() {
  local repo_path="$1"
  local name
  name=$(basename "$repo_path" | tr '-' '_')
  if [ -f "$repo_path/pyproject.toml" ] && [ -d "$repo_path/$name" ]; then
    echo "\`$name/\`"
  else
    echo "—"
  fi
}

emit_group_table() {
  local group="$1"
  local group_dir="$ROOT_DIR/$group"
  [ -d "$group_dir" ] || return
  echo ""
  echo "| Name | Path | Stack | Source Package |"
  echo "|------|------|-------|----------------|"
  for repo in "$group_dir"/*/; do
    [ -d "$repo/.git" ] || continue
    repo=${repo%/}
    local name
    name=$(basename "$repo")
    local stack
    stack=$(sniff_stack "$repo")
    local pkg
    pkg=$(source_package "$repo")
    echo "| $name | \`$repo\` | $stack | $pkg |"
  done
}

emit_inactive_list() {
  local group="$1"
  local group_dir="$ROOT_DIR/$group"
  [ -d "$group_dir" ] || return
  echo ""
  echo "| Name | Path |"
  echo "|------|------|"
  for repo in "$group_dir"/*/; do
    [ -d "$repo/.git" ] || continue
    repo=${repo%/}
    echo "| $(basename "$repo") | \`$repo\` |"
  done
}

echo "Regenerating PROJECT_INDEX.md..."
{
  echo "# Project Index"
  echo ""
  echo "> Auto-generated by \`sync_repos.sh\`. Do not hand-edit — rerun sync to refresh."
  echo "> Agents: read this before searching for a project directory."
  echo ""
  echo "## Root"
  echo ""
  echo "| Name | Path | Notes |"
  echo "|------|------|-------|"
  echo "| PycharmProjects (root) | \`$ROOT_DIR\` | workspace root; not a service |"

  for group in "${ACTIVE_GROUPS[@]}"; do
    [ -d "$ROOT_DIR/$group" ] || continue
    echo ""
    echo "---"
    echo ""
    echo "## $group"
    emit_group_table "$group"
  done

  echo ""
  echo "---"
  echo ""
  echo "## Inactive / Archival Groups"
  echo ""
  echo "Not maintained active services. Excluded from default agent search scope (ast-grep / CodeGraphContext ignore list)."
  echo "Confirm before treating anything here as dead — check \`git log -5\` in the specific repo first."

  for group in "${INACTIVE_GROUPS[@]}"; do
    [ -d "$ROOT_DIR/$group" ] || continue
    echo ""
    echo "### $group (inactive)"
    emit_inactive_list "$group"
  done

  echo ""
  echo "---"
  echo ""
  echo "## Cross-Service Notes"
  echo ""
  echo "- Inter-service auth: \`x-service-key\` header"
  echo "- Git remote: \`git.maxpool.ir\` (Bitbucket) — use SSH for push/pull"
  echo "- CI: Bamboo (\`DEV/bamboo-specs\`)"
  echo "- Monitoring: Grafana + Sentry (\`EB-*\`, \`COM-*\` projects)"
  echo "- Jira: CF project (features), CS project (customer support)"
} > "$INDEX_FILE"

echo "PROJECT_INDEX.md regenerated at $INDEX_FILE"
