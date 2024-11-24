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
kubectl kubectx kubetail
vault
ssh-agent
crowdsec
z 
vscode
#cp colorize copyfile encode64  history
#percol pylint
 fzf fzf-tab )
[ "`uname`" = "Linux" ] && plugins=($plugins ubuntu) || plugins=($plugins brew)
zstyle :omz:plugins:ssh-agent agent-forwarding yes
source $ZSH/oh-my-zsh.sh
unalias rm
#export PATH="$PATH:`yarn global bin`"
export VAULT_ADDR="https://keys.mybitmax.com"
#export FZF_DEFAULT_OPTS="--no-mouse --height 50% --reverse --multi --inline-info  --preview='[[ \$(file --mime-type {}) =~ binary ]] && echo {} is a binary file || (batcat --color=always {}||less -S {}) 2> /dev/null|head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(batcat {}|less -S {} ),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+}|xclip)'" 



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completio
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
[ -f ~/.zshrc_local ] && source ~/.zshrc_local`

