# klog_deploy.zsh - Tail logs for all pods of a deployment, with FZF and color
klog_deploy() {
  local deployment=$1
  local namespace=${2:-$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)}
  namespace=${namespace:-default}

  local pids=()
  cleanup() {
    echo "\n🛑 Stopping all log streams..."
    for pid in "${pids[@]}"; do
      kill "$pid" 2>/dev/null
    done
    exit 0
  }
  trap cleanup INT

  if [[ -z "$deployment" ]]; then
    echo "📋 Select a deployment to tail logs from:"
    deployment=$(kubectl get deployments -n "$namespace" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | fzf)
    if [[ -z "$deployment" ]]; then
      echo "❌ No deployment selected"
      return 1
    fi
  fi

  echo "🔍 Fetching pods for deployment '$deployment' in namespace '$namespace'..."

  local selector
  selector=$(kubectl get deployment "$deployment" -n "$namespace" -o jsonpath='{.spec.selector.matchLabels}' | jq -r 'to_entries|map("\(.key)=\(.value)")|join(",")')

  if [[ -z "$selector" ]]; then
    echo "❌ Failed to get label selector for deployment $deployment"
    return 1
  fi

  echo "🎯 Label selector: $selector"

  local pods
  pods=("${(@f)$(kubectl get pods -n "$namespace" -l "$selector" -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}')}")

  if [[ ${#pods[@]} -eq 0 ]]; then
    echo "⚠️ No pods found for deployment $deployment"
    return 1
  fi

  echo "📦 Tailing logs for ${#pods[@]} pods..."

  local colors=(
    "1;31" "1;32" "1;33" "1;34"
    "1;35" "1;36" "1;91" "1;92"
    "1;93" "1;94" "1;95" "1;96"
  )

  for i in {1..${#pods[@]}}; do
    local pod="${pods[i]}"
    local color="${colors[$(( (i - 1) % ${#colors[@]} + 1 ))]}"
    {
      kubectl logs -n "$namespace" -f "$pod" 2>/dev/null |
      sed "s/^/$(printf '\033[%sm[%s]\033[0m ' "$color" "$pod")/"
    } &
    pids+=($!)
  done

  echo "⏳ Press Ctrl+C to stop all logs"
  wait
}
