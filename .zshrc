export ZSH=$HOME/.oh-my-zsh
export PATH="$HOME/bin:/snap/bin:$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
autoload -U compinit; compinit
# ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE=true
ZSH_THEME="ali"
plugins=(
docker docker-compose
postgres 
git
pip python virtualenv 
poetry
systemd 
ubuntu common-aliases sudo ali-aliases
fast-syntax-highlighting
zsh-autosuggestions
alias-tips
colored-man-pages
kubectl
podman
vault
)
[ -e $HOME/.ssh/id_rsa -o -e  $HOME/.ssh/id_ed255191 -o -e $HOME/.ssh/id_ecdsa ] && plugins=(${plugins} ssh-agent)

source $ZSH/oh-my-zsh.sh
unalias rm
#export PATH="$PATH:`yarn global bin`"
export VAULT_ADDR="https://keys.mybitmax.com"



