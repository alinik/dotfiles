complete -c krrd -f -a '(kubectl get deployments -o name 2>/dev/null | string replace -r "^deployment.apps/" "")'
