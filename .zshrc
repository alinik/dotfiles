export ZSH=$HOME/.oh-my-zsh
export PATH="$HOME/bin:/snap/bin:$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
autoload -U compinit; compinit
# ZSH_THEME="af-magic"
ZSH_THEME="ali"
plugins=(
docker docker-compose
postgres 
git
pip python virtualenv celery
systemd 
ubuntu common-aliases sudo ali-aliases
fast-syntax-highlighting
zsh-autosuggestions
globalias #alias-tips
colored-man-pages
kubectl kubectx
vault
ssh-agent
crowdsec
z 
#cp z colorize copyfile encode64  history
#percol pylint
)
zstyle :omz:plugins:ssh-agent agent-forwarding yes
source $ZSH/oh-my-zsh.sh
unalias rm
#export PATH="$PATH:`yarn global bin`"
export VAULT_ADDR="https://keys.mybitmax.com"

___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi


