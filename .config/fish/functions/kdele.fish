function kdele --description 'delete pods stuck Completed/Error/Pending/CrashLooping across all namespaces (optional: cluster context)'
    if not command -v kubectl >/dev/null 2>&1
        echo "kdele: kubectl not found in PATH." >&2
        return 127
    end

    set -l ctx_args
    if test (count $argv) -ge 1
        set ctx_args --context=$argv[1]
    end

    kubectl get pods --all-namespaces $ctx_args | awk '/Comp|Error|Pending|Cras/ {print $1, $2}' | while read -l namespace pod
        echo -n "$namespace: "
        kubectl delete pod $pod -n $namespace $ctx_args
    end
end
