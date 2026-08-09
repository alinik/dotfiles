#!/bin/bash
set -euo pipefail

# Error handler function
error_exit() {
  local repo_name="${CURRENT_REPO:-unknown}"
  echo "ERROR: Command failed in repository: $repo_name"
  exit 1
}

# Set up trap to call error_exit on any error
trap 'error_exit' ERR

MERGE_QC=false
if [[ "${1:-}" == "--merge-qc" ]]; then
  MERGE_QC=true
fi

TMP_ROWS="$(mktemp)"
trap 'rm -f "$TMP_ROWS"' EXIT

# Find all Git repos with master, stage, and qc branches
fd -t d -u -a -E OLD -E DEV -E MD .git$ | sort | while IFS= read -r gitdir; do
  (
    repo=$(dirname "$gitdir")
    export CURRENT_REPO="$repo"

    cd "$repo" || { echo "ERROR: could not enter directory $repo"; exit 1; }

    if git show-ref --quiet refs/heads/master && git show-ref --quiet refs/heads/stage && git show-ref --quiet refs/heads/qc; then
      git fetch --all --prune --quiet

      current_branch=$(git rev-parse --abbrev-ref HEAD)

      STASHED=false
      if [[ -n "$(git status --porcelain)" ]]; then
        git stash push -u -q -m "auto-sync $(date +%F_%T)" || echo "  Warning: could not stash changes in $repo." >&2
        STASHED=true
      fi

      for b in master stage qc; do
        if [[ "$(git rev-parse --abbrev-ref HEAD)" != "$b" ]]; then
          git checkout -q "$b"
        fi
        git pull --ff-only -q || echo "  Note: $b not fast-forwardable; left unchanged." >&2
      done

      # stage -> qc
      stage_qc_ahead=$(git rev-list --count origin/qc..origin/stage || echo 0)
      stage_qc_behind=$(git rev-list --count origin/stage..origin/qc || echo 0)

      # qc -> master
      qc_master_ahead=$(git rev-list --count origin/master..origin/qc || echo 0)
      qc_master_behind=$(git rev-list --count origin/qc..origin/master || echo 0)

      if $MERGE_QC && [[ "$stage_qc_behind" -ne 0 ]]; then
        echo "  Merging qc into stage in $repo ..." >&2
        git checkout -q stage
        if git merge --no-edit origin/qc; then
          git push -q origin stage && echo "  Pushed merged qc->stage in $repo" >&2
          stage_qc_behind=0
        else
          echo "  Merge conflict merging qc into stage in $repo" >&2
        fi
      fi

      if [[ "$(git rev-parse --abbrev-ref HEAD)" != "$current_branch" ]]; then
        git checkout -q "$current_branch"
      fi

      if [[ "$STASHED" == "true" ]]; then
        if git stash list | grep -q "auto-sync"; then
          git stash pop -q || echo "  Warning: conflicts when restoring stash in $repo." >&2
        fi
      fi

      if [[ "$stage_qc_ahead" -ne 0 || "$stage_qc_behind" -ne 0 || "$qc_master_ahead" -ne 0 || "$qc_master_behind" -ne 0 ]]; then
        printf '%s\t+%s/-%s\t+%s/-%s\n' "$repo" "$stage_qc_ahead" "$stage_qc_behind" "$qc_master_ahead" "$qc_master_behind" >> "$TMP_ROWS"
      fi
    fi
  )
done

# Render table
{
  printf 'REPO\tSTAGE→QC (ahead/behind)\tQC→MASTER (ahead/behind)\n'
  sort "$TMP_ROWS"
} | column -t -s $'\t'
