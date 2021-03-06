  export ZSH=$HOME/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# ZSH_THEME="af-magic"
ZSH_THEME="ali"
plugins=(
docker docker-compose
lxd-completion 
postgres sublime fabric git
pip python virtualenv 
autoenv
nvm 
systemd supervisor
ubuntu common-aliases zsh_reload ssh-agent sudo
ali-aliases
zsh-syntax-highlighting
)
export PATH="$HOME/bin:/snap/bin:$PATH"
source $ZSH/oh-my-zsh.sh
unalias rm
#export PATH="$PATH:`yarn global bin`"

