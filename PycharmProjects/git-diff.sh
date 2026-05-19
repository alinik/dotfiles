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

AUTO_MERGE=false
if [[ "${1:-}" == "--merge" ]]; then
  AUTO_MERGE=true
fi

# Find all Git repos with both master and stage branches
fd -t d -u -a -E OLD -E DEV -E MD .git$ | sort|while IFS= read -r gitdir; do
  (
    repo=$(dirname "$gitdir")
    # Set current repo for error handling
    export CURRENT_REPO="$repo"
    
    # echo "Processing repository: $repo"
    cd "$repo" || { echo "ERROR: could not enter directory $repo"; exit 1; }

    # Ensure both branches exist locally
    if git show-ref --quiet refs/heads/master && git show-ref --quiet refs/heads/stage; then
      git fetch --all --prune --quiet

      current_branch=$(git rev-parse --abbrev-ref HEAD)

      # Detect dirty state and stash if needed (include untracked)
      STASHED=false
      if [[ -n "$(git status --porcelain)" ]]; then
        git stash push -u -q -m "auto-sync $(date +%F_%T)" || echo "  Warning: could not stash changes in $repo."
        STASHED=true
      fi
      # Pull fast-forward on master and stage
      for b in master stage; do
        # If current branch equals b, no need to checkout
        if [[ "$(git rev-parse --abbrev-ref HEAD)" != "$b" ]]; then
          git checkout -q "$b"
        fi
        # Try fast-forward only; if it can't FF, just fetch leaves it as-is
        git pull --ff-only -q || echo "  Note: $b not fast-forwardable; left unchanged."
      done

      # Compute ahead/behind before changes (optional info)
      ahead=$(git rev-list --count origin/master..origin/stage || echo 0)
      behind=$(git rev-list --count origin/stage..origin/master || echo 0)
      dirty_status=$([[ "$STASHED" == "true" ]] && echo "dirty" || echo "clean")
      if [[ "$ahead" -eq 0 && "$behind" -eq 0 ]]; then
        # No differences
        if [[ "$STASHED" == "true" ]]; then
          # Restore stashed changes if any
          if git stash list | grep -q "auto-sync"; then
            git stash pop -q || echo "  Warning: conflicts when restoring stash in $repo."
          fi
        fi
        # Return to original branch if changed
        if [[ "$(git rev-parse --abbrev-ref HEAD)" != "$current_branch" ]]; then
          git checkout -q "$current_branch"
        fi
        # No output needed for clean repos with no changes
        continue
      fi
      
      echo "Repo: $repo"
      echo "  Current branch: $current_branch ($dirty_status before sync)"
      echo -e "  stage is \033[1;33m$ahead\033[0m ahead, \033[1;31m$behind\033[0m behind master"


      if $AUTO_MERGE; then
        echo "  Merging master into stage..."
        git checkout -q stage
        if git merge --no-edit master; then
          echo "  Merge complete in $repo"
          git push -q origin stage && echo "  Pushed merged changes to origin/stage"
        else
          echo -e "  \033[1;31mMerge conflict detected in $repo\033[0m"
        fi
      fi

      # Return to original branch
      if [[ "$(git rev-parse --abbrev-ref HEAD)" != "$current_branch" ]]; then
        git checkout -q "$current_branch"
      fi

      # Restore stashed changes if any
      if [[ "$STASHED" == "true" ]]; then
        if git stash list | grep -q "auto-sync"; then
          git stash pop -q || echo "  Warning: conflicts when restoring stash in $repo."
        fi
      fi

      echo
    fi
  )
done
