alias noc='grep -vE "^\s*[#;]|^\s*$"'
alias fps='ps -ef|grep -v grep|grep'
alias catc='pygmentize -g'
alias dm='du -sxm *|sort -nr|head'
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cmdb='git --git-dir=/root/.cmdb --work-tree=/' # mkdir /root/.cmdb && cd /root/.cmdb && git init --bare . 
alias tailf='tail -f'
alias csf='sudo csf'
alias krr='kubectl rollout restart deployment '
alias kdele='for i in `kubectl get pods |awk "/Error/ {print $1}"`;do kubectl delete pods $i;done'
export GLOBALIAS_FILTER_VALUES="$GLOBALIAS_FILTER_VALUES krr glola gp gl gco gcam gss gd fps dm config cmdb noc G L z agud" 
if [ `id -u` -ne 0 ]; then
    for cmd in apt iptables ip ss smem dpkg apt-get snap systemctl chown ntpdate ;
        do
           alias $cmd="sudo $cmd"
        done
fi
function nocc(){
	pygmentize -g $1|grep -Ev '^\s*.{0,5}#|^$'
}
