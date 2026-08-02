function krrd --description 'kubectl rollout restart deployment, with fzf multi-select if no args'
    if not command -v kubectl >/dev/null 2>&1
        echo "krrd: kubectl not found in PATH." >&2
        return 127
    end

    if test (count $argv) -eq 0
        echo "🔍 No deployment specified. Launching fzf to select..."
        set -l selected (kubectl get deployments -o name | sed 's|^deployment.apps/||' | fzf --multi --prompt="Select deployments to restart: ")

        if test -z "$selected"
            echo "❌ No deployment selected. Cancelled."
            return 1
        end
        echo "🚀 Restarting: $selected"
        kubectl rollout restart deployment $selected
    else
        kubectl rollout restart deployment $argv
    end
end
