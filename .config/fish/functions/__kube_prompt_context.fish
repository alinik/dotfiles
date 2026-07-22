function __kube_prompt_context -d "Print the current kubectl context name (reads kubeconfig directly, no kubectl needed)"
    set -l kubeconfig_path $KUBECONFIG
    if test -z "$kubeconfig_path"
        set kubeconfig_path $HOME/.kube/config
    end
    # KUBECONFIG may be a colon-separated list; use the first existing file
    for path in (string split ':' -- $kubeconfig_path)
        if test -f "$path"
            grep -m1 '^current-context:' "$path" | string replace -r '^current-context:\s*' ''
            return
        end
    end
end
