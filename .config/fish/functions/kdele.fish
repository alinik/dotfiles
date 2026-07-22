function kdele --description 'delete pods stuck Completed/Error/Pending/CrashLooping across all namespaces'
    kubectl get pods --all-namespaces | awk '/Comp|Error|Pending|Cras/ {print $1, $2}' | while read -l namespace pod
        echo -n "$namespace: "
        kubectl delete pod $pod -n $namespace
    end
end
