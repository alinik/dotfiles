function kdele --description 'delete pods stuck Completed/Error/Pending/CrashLooping across all namespaces'
    if not command -v kubectl >/dev/null 2>&1
        echo "kdele: kubectl not found in PATH." >&2
        return 127
    end

    kubectl get pods --all-namespaces | awk '/Comp|Error|Pending|Cras/ {print $1, $2}' | while read -l namespace pod
        echo -n "$namespace: "
        kubectl delete pod $pod -n $namespace
    end
end
