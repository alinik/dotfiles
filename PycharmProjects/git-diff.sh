#!/bin/bash

AUTO_MERGE=false
if [[ "$1" == "--merge" ]]; then
  AUTO_MERGE=true
fi

# Find all Git repos with both master and stage branches
fd -t d -u -a .git$ | while read gitdir; do
  repo=$(dirname "$gitdir")
  cd "$repo" || continue

  # Ensure both branches exist
  if git show-ref --quiet refs/heads/master && git show-ref --quiet refs/heads/stage; then
    git fetch --all --quiet

    # Determine branch, dirty status, ahead/behind counts
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ -n $(git status --porcelain) ]]; then
      dirty_status="dirty"
    else
      dirty_status="clean"
    fi

    ahead=$(git rev-list --count master..stage)
    behind=$(git rev-list --count stage..master)

    # Only show repos that are dirty or out-of-sync
    if [[ "$dirty_status" != "clean" || $ahead -gt 0 || $behind -gt 0 ]]; then
      echo "Repo: $repo"
      echo "  Current branch: $current_branch ($dirty_status)"
      echo -e "  stage is \033[1;33m$ahead\033[0m ahead, \033[1;31m$behind\033[0m behind master"
      echo

      if $AUTO_MERGE; then
        echo "  Merging master into stage..."
        git checkout stage && git merge master --no-edit
        if [ $? -ne 0 ]; then
          echo -e "  \033[1;31mMerge conflict detected in $repo\033[0m"
        else
          echo "  Merge complete in $repo"
          git push origin stage
          echo "  Pushed merged changes to origin/stage"
        fi
        echo
        git checkout "$current_branch" --quiet
      fi
    fi
  fi
done
