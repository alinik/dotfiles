function fish_right_prompt -d "Right prompt: status, git branch (dirty or typing git), kube ctx (typing kubectl)"
    set -l last_status $status
    set -l cmd (commandline)

    set -l segs

    if test "$hostname" != "CTO.local"
        set -a segs (set_color 5fafff)"$USER@$hostname"(set_color normal)
    end

    if test $last_status -ne 0
        set -a segs (set_color red)"✗$last_status"(set_color normal)
    end

    set -l git_branch (__git.current_branch 2>/dev/null)
    if test -n "$git_branch"
        if string match -qr '^\s*git\b' -- $cmd; or __git.is_dirty
            set -l git_info (__git.prompt_segment)
            set -a segs (set_color yellow)"($git_info)"(set_color normal)
        end
    end

    if set -q VIRTUAL_ENV
        set -a segs (set_color cyan)"($(basename $VIRTUAL_ENV))"(set_color normal)
    end

    if string match -qr '^\s*kubectl\b' -- $cmd
        set -l kube_ctx (__kube_prompt_context)
        if test -n "$kube_ctx"
            set -a segs (set_color magenta)"⎈ $kube_ctx"(set_color normal)
        end
    end

    string join ' ' -- $segs
end
