#!/bin/bash
set -uo pipefail

usage() {
  cat <<'EOF'
Usage: git-diff.sh [OPTION] [--jobs N]

Scan repos with master/stage/qc branches, report ahead/behind counts,
and optionally merge branches forward. Repos are processed in parallel.

Options:
  --sync-qc      Merge qc into stage and push (if stage is behind qc)
  --sync-master  Merge master into qc and push, then merge master into
                 stage and push
  --sync         Full chain: merge master into qc and push, then merge
                 qc into stage and push
  --push-qc      Merge stage into qc and push, in ALL repos (if qc is
                 behind stage; excludes front-main)
  --push-master  Merge qc into master and push, in ALL repos (if master
                 is behind qc; excludes front-main). Asks for confirmation
                 first.
  --jobs N       Number of repos to process concurrently (default: 4)
  -h, --help     Show this help and exit
EOF
}

MODE=none
JOBS=4
while [[ $# -gt 0 ]]; do
  case "$1" in
    --sync-qc) MODE=sync-qc; shift ;;
    --sync-master) MODE=sync-master; shift ;;
    --sync) MODE=sync; shift ;;
    --push-qc) MODE=push-qc; shift ;;
    --push-master) MODE=push-master; shift ;;
    --jobs) JOBS="${2:?--jobs requires a value}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
  esac
done

if [[ "$MODE" == "push-master" ]]; then
  read -r -p "This will merge qc into master and push, in ALL repos. Continue? [y/N] " confirm
  [[ "$confirm" == [Yy]* ]] || { echo "Aborted." >&2; exit 1; }
fi

TMP_ROWS="$(mktemp)"
TMP_EVENTS="$(mktemp)"
trap 'rm -f "$TMP_ROWS" "$TMP_EVENTS"' EXIT

# merge_and_push <from-branch> <into-branch> <repo-label>
# Checks out <into>, merges origin/<from>, pushes on success.
merge_and_push() {
  local from="$1" into="$2" repo="$3"
  echo "  Merging $from into $into in $repo ..." >&2
  git checkout -q "$into" || return 1
  if git merge --no-edit "origin/$from"; then
    if git push -q origin "$into"; then
      echo "  Pushed merged $from->$into in $repo" >&2
      echo "PUSHED" >> "$TMP_EVENTS"
      return 0
    fi
    echo "  Push failed for $into in $repo" >&2
    echo "PUSH_FAILED" >> "$TMP_EVENTS"
    return 1
  fi
  echo "  Merge conflict merging $from into $into in $repo" >&2
  echo "CONFLICT" >> "$TMP_EVENTS"
  return 1
}
export -f merge_and_push

# process_repo <path-to-.git-dir>
# Skips repos that don't have master/stage/qc. Appends a result row to
# TMP_ROWS when there's any ahead/behind drift left after merging.
process_repo() {
  local gitdir="$1" repo
  repo=$(dirname "$gitdir")

  cd "$repo" || { echo "ERROR: could not enter directory $repo" >&2; return 1; }

  printf '.' >&2

  git show-ref --quiet refs/heads/master \
    && git show-ref --quiet refs/heads/stage \
    && git show-ref --quiet refs/heads/qc \
    || return 0

  echo "SCANNED" >> "$TMP_EVENTS"

  git fetch --all --prune --quiet || { echo "  ERROR: fetch failed in $repo" >&2; return 1; }

  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  local stashed=false
  if [[ -n "$(git status --porcelain)" ]]; then
    git stash push -u -q -m "auto-sync $(date +%F_%T)" || echo "  Warning: could not stash changes in $repo." >&2
    stashed=true
  fi

  local b
  for b in master stage qc; do
    [[ "$(git rev-parse --abbrev-ref HEAD)" != "$b" ]] && git checkout -q "$b"
    git pull --ff-only -q || echo "  Note: $b not fast-forwardable; left unchanged." >&2
  done

  local stage_qc_ahead stage_qc_behind qc_master_ahead qc_master_behind
  stage_qc_ahead=$(git rev-list --count origin/qc..origin/stage || echo 0)
  stage_qc_behind=$(git rev-list --count origin/stage..origin/qc || echo 0)
  qc_master_ahead=$(git rev-list --count origin/master..origin/qc || echo 0)
  qc_master_behind=$(git rev-list --count origin/qc..origin/master || echo 0)

  case "$MODE" in
    sync-qc)
      if [[ "$stage_qc_behind" -ne 0 ]] && merge_and_push qc stage "$repo"; then
        stage_qc_behind=0
      fi
      ;;
    push-qc)
      if [[ "$(basename "$repo")" == "front-main" ]]; then
        echo "  Skipping push-qc for $repo (excluded)" >&2
      elif [[ "$stage_qc_ahead" -ne 0 ]] && merge_and_push stage qc "$repo"; then
        stage_qc_ahead=0
      fi
      ;;
    push-master)
      if [[ "$(basename "$repo")" == "front-main" ]]; then
        echo "  Skipping push-master for $repo (excluded)" >&2
      elif [[ "$qc_master_ahead" -ne 0 ]] && merge_and_push qc master "$repo"; then
        qc_master_ahead=0
      fi
      ;;
    sync)
      if [[ "$qc_master_behind" -ne 0 ]] && merge_and_push master qc "$repo"; then
        qc_master_behind=0
        stage_qc_behind=$(git rev-list --count origin/stage..origin/qc || echo 0)
      fi
      if [[ "$stage_qc_behind" -ne 0 ]] && merge_and_push qc stage "$repo"; then
        stage_qc_behind=0
      fi
      ;;
    sync-master)
      if [[ "$qc_master_behind" -ne 0 ]] && merge_and_push master qc "$repo"; then
        qc_master_behind=0
      fi
      local stage_master_behind
      stage_master_behind=$(git rev-list --count origin/stage..origin/master || echo 0)
      if [[ "$stage_master_behind" -ne 0 ]]; then
        merge_and_push master stage "$repo"
      fi
      ;;
  esac

  [[ "$(git rev-parse --abbrev-ref HEAD)" != "$current_branch" ]] && git checkout -q "$current_branch"

  if [[ "$stashed" == "true" ]] && git stash list | grep -q "auto-sync"; then
    git stash pop -q || echo "  Warning: conflicts when restoring stash in $repo." >&2
  fi

  if [[ "$stage_qc_ahead" -ne 0 || "$stage_qc_behind" -ne 0 || "$qc_master_ahead" -ne 0 || "$qc_master_behind" -ne 0 ]]; then
    printf '%s\t%s\t%s\t%s\t%s\n' "$repo" "$stage_qc_ahead" "$stage_qc_behind" "$qc_master_ahead" "$qc_master_behind" >> "$TMP_ROWS"
  fi
}
export -f process_repo
export MODE TMP_ROWS TMP_EVENTS

# Find all Git repos with master, stage, and qc branches; process concurrently.
fd -t d -u -a -E OLD -E DEV -E MD .git$ | sort \
  | xargs -P "$JOBS" -I{} bash -c 'process_repo "$0"' {}

echo >&2

# Render table (light green: qc ahead of stage; light yellow: master ahead of qc)
sort "$TMP_ROWS" | awk -F'\t' '
{
  repo[NR]=$1
  b1[NR]=$3; col1[NR]=sprintf("+%s/-%s", $2, $3)
  b2[NR]=$5; col2[NR]=sprintf("+%s/-%s", $4, $5)
  if (length($1) > wr) wr = length($1)
  if (length(col1[NR]) > w1) w1 = length(col1[NR])
  if (length(col2[NR]) > w2) w2 = length(col2[NR])
}
END {
  green = "\033[92m"; yellow = "\033[93m"; reset = "\033[0m"
  h0 = "REPO"; h1 = "STAGE→QC (ahead/behind)"; h2 = "QC→MASTER (ahead/behind)"
  if (length(h0) > wr) wr = length(h0)
  if (length(h1) > w1) w1 = length(h1)
  if (length(h2) > w2) w2 = length(h2)
  printf "%-*s  %-*s  %-*s\n", wr, h0, w1, h1, w2, h2
  for (i = 1; i <= NR; i++) {
    p1 = sprintf("%-*s", w1, col1[i])
    p2 = sprintf("%-*s", w2, col2[i])
    if (b1[i] + 0 > 0) p1 = green p1 reset
    if (b2[i] + 0 > 0) p2 = yellow p2 reset
    printf "%-*s  %s  %s\n", wr, repo[i], p1, p2
  }
}'

# Summary
scanned=$(grep -c '^SCANNED$' "$TMP_EVENTS" || true)
drift=$(wc -l < "$TMP_ROWS" | tr -d ' ')
pushed=$(grep -c '^PUSHED$' "$TMP_EVENTS" || true)
conflicts=$(grep -c '^CONFLICT$' "$TMP_EVENTS" || true)
push_failed=$(grep -c '^PUSH_FAILED$' "$TMP_EVENTS" || true)

echo
echo "Summary: ${scanned:-0} scanned, ${drift:-0} with drift, ${pushed:-0} pushed, ${conflicts:-0} conflicts, ${push_failed:-0} push failures"
