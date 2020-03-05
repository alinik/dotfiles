alias noc='grep -vE "^\s*[#;]|^\s*$"'
alias fps='ps -ef|grep -v grep|grep'
alias catc='pygmentize -g'
alias dm='du -sxm *|sort -nr|head'
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias tailf='tail -f'
if [ `id -u` -ne 0 ]; then
    for cmd in apt iptables ip ss smem dpkg apt-get snap systemctl chown ntpdate ;
        do
           alias $cmd="sudo $cmd"
        done
fi
function nocc(){
	pygmentize -g $1|grep -Ev '^\s*.{0,5}#|^$'
}
