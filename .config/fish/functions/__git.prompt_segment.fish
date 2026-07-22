function __git.prompt_segment -d "Build git status segment: branch, +staged ~unstaged ?untracked, ahead/behind origin"
    set -l branch (__git.current_branch)
    if test -z "$branch"
        return
    end

    set -l parts $branch

    set -l staged (git diff --cached --name-only 2>/dev/null | count)
    set -l unstaged (git diff --name-only 2>/dev/null | count)
    set -l untracked (git ls-files --others --exclude-standard 2>/dev/null | count)

    test $staged -gt 0; and set -a parts "+$staged"
    test $unstaged -gt 0; and set -a parts "~$unstaged"
    test $untracked -gt 0; and set -a parts "?$untracked"

    set -l upstream (git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
    if test -n "$upstream"
        set -l ab (git rev-list --left-right --count 'HEAD...@{u}' 2>/dev/null | string split \t)
        set -l ahead $ab[1]
        set -l behind $ab[2]
        if test -n "$ahead" -a "$ahead" -gt 0
            set -a parts "↑$ahead"
        end
        if test -n "$behind" -a "$behind" -gt 0
            set -a parts "↓$behind"
        end
    end

    string join ' ' -- $parts
end
