alias noc='grep -vE "^\s*[#;]|^\s*$"'
alias fps='ps -ef|grep -v grep|grep'
alias catc='pygmentize -g'
alias dm='du -sxm *|sort -nr|head'
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cmdb='git --git-dir=/root/.cmdb --work-tree=/' # mkdir /root/.cmdb && cd /root/.cmdb && git init --bare . 
alias tailf='tail -f'
alias csf='sudo csf'
alias krrf='kubectl rollout restart -f '
alias -g GG='| grep -Ev "status|metric|Successfully"'
alias dive='docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive'
alias blockchain='kubectl config use-context blockchain@prod'
alias prod='kubectl config use-context exchange@prod'
alias stage='kubectl config use-context exchange@stage'
alias mkenv="kubectl get configmaps -o yaml general-secret|yq .data|sed 's/: /=/' > .env"

export GLOBALIAS_FILTER_VALUES="$GLOBALIAS_FILTER_VALUES krr glola gp gl gco gcam gss gd fps dm config cmdb noc G L z agud dive"
if [ `id -u` -ne 0 ]; then
    for cmd in apt iptables ip ss smem dpkg apt-get snap systemctl chown ntpdate ;
        do
           alias $cmd="sudo $cmd"
        done
fi
function nocc(){
	pygmentize -g $1|grep -Ev '^\s*.{0,5}#|^$'
}
krrd() {
  if [ $# -eq 0 ]; then
    echo "🔍 No deployment specified. Launching fzf to select..."
    selected=$(kubectl get deployments -o name | sed 's|^deployment.apps/||' | fzf --multi --prompt="Select deployments to restart: ")

    if [ -z "$selected" ]; then
      echo "❌ No deployment selected. Cancelled."
      return 1
    fi
    echo "🚀 Restarting: $selected"
    kubectl rollout restart deployment $selected
  else
    kubectl rollout restart deployment "$@"
  fi
}

kdele() {
  kubectl get pods --all-namespaces | awk '/Comp|Error|Pending|Cras/ {print $1, $2}' | while read namespace pod; do
    echo -n "$namespace: "
    kubectl delete pod "$pod" -n "$namespace" 
  done
}

dkb() {
  # 1. Preflight: ensure Colima is running
  if ! colima status >/dev/null 2>&1; then
    echo "⚠️  Colima is not running. Starting Colima..."
    colima start
    # wait until Colima is ready
        while ! colima status 2>&1| grep -q "colima is running"; do
      sleep 1
    done
    echo "✅ Colima is up."
  fi

  # 2. Determine current directory name and Git branch
  local image_name=$(basename "$PWD")
  local branch=$(git rev-parse --abbrev-ref HEAD)

  # 3. Run Docker build
  docker build . \
    --platform=linux/amd64/v2 \
    --build-arg BRANCH="$branch" \
    -t "reg.maxpool.ir/applications/${image_name}:${branch}" \
    "$@"
}
