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
globalias 
#alias-tips
colored-man-pages
kubectl kubectx
vault
ssh-agent
crowdsec
z 
#cp z colorize copyfile encode64  history
#percol pylint
 fzf)
zstyle :omz:plugins:ssh-agent agent-forwarding yes
source $ZSH/oh-my-zsh.sh
unalias rm
#export PATH="$PATH:`yarn global bin`"
export VAULT_ADDR="https://keys.mybitmax.com"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% --reverse --multi --inline-info  --preview='[[ \$(file --mime-type {}) =~ binary ]] && echo {} is a binary file || (batcat --color=always {}||less -S {}) 2> /dev/null|head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(batcat {}|less -S {} ),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+}|xclip)'" 


___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
