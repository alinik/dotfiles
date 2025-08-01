export ZSH=$HOME/.oh-my-zsh
export PATH="$HOME/bin:$HOME/.local/bin:/snap/bin:$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
autoload -U compinit; compinit
# ZSH_THEME="af-magic"
ZSH_THEME="ali"
plugins=(
docker docker-compose
postgres 
git
pip python virtualenv celery
systemd 
common-aliases sudo ali-aliases
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
vscode
#cp colorize copyfile encode64  history
#percol pylint
klog-deploy
ruff
kubetail
nvm
iterm2
 fzf fzf-tab )
[ "`uname`" = "Linux" ] && plugins=($plugins ubuntu) || plugins=($plugins brew)
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:iterm2 shell-integration yes
source "$ZSH/plugins/iterm2/iterm2_shell_integration.zsh"
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
source $ZSH/oh-my-zsh.sh
unalias rm
#export PATH="$PATH:`yarn global bin`"
export VAULT_ADDR="https://keys.mybitmax.com"
#export FZF_DEFAULT_OPTS="--no-mouse --height 50% --reverse --multi --inline-info  --preview='[[ \$(file --mime-type {}) =~ binary ]] && echo {} is a binary file || (batcat --color=always {}||less -S {}) 2> /dev/null|head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(batcat {}|less -S {} ),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+}|xclip)'" 

# Created by `userpath` on 2025-05-20 05:03:21
export PATH="$PATH:/Users/ali/Library/Application Support/hatch/pythons/3.13/python/bin"
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/vault vault
