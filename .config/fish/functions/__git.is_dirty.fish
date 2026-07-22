function __git.is_dirty -d "Return 0 (true) if git working tree has uncommitted or untracked changes"
    if not git diff --quiet --ignore-submodules HEAD -- 2>/dev/null
        return 0
    end
    set -l untracked (git ls-files --others --exclude-standard 2>/dev/null | head -n1)
    test -n "$untracked"
end
