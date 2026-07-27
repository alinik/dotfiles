if status is-interactive
    alias fps 'ps -ef | grep -v grep | grep'
    alias catc 'pygmentize -g'
    alias dm 'du -axh . | sort -hr | head -n 30'
    alias config 'git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    alias cmdb 'git --git-dir=/root/.cmdb --work-tree=/' # mkdir /root/.cmdb && cd /root/.cmdb && git init --bare .
    alias tailf 'tail -f'
    alias csf 'sudo csf'
    alias krrf 'kubectl rollout restart -f '
    alias blockchain 'kubectl config use-context blockchain@prod'
    alias prod 'kubectl config use-context exchange@prod'
    alias stage 'kubectl config use-context exchange@stage'
    alias kt kubetail
    alias bump 'git commit --allow-empty -m "bump for rebuild" && git push'
    alias c claude
    alias o codex
    alias glola 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'

    if test (id -u) -ne 0
        for cmd in apt iptables ip ss smem dpkg apt-get snap systemctl chown ntpdate
            alias $cmd "sudo $cmd"
        end
    end

    # zsh global aliases (`alias -g`) -> fish abbr --position anywhere
    abbr -a --position anywhere GG '| grep -Ev "status|metric|Successfully"'
    abbr -a --position anywhere G "|grep --color"
end
