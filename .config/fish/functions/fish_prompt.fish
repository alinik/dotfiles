function fish_prompt -d "Prompt: cwd only, git/kube/status live on the right"
    set -l cwd_seg (set_color green)(prompt_pwd)(set_color normal)
    echo -n -s $cwd_seg ' ❯ '
end
