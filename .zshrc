  export ZSH=/home/ali/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# ZSH_THEME="af-magic"
ZSH_THEME="ali"
plugins=(git sudo virtualenv virtualenvwrapper docker docker-compose postgres ssh-agent pip sudo z systemd supervisor fabric gulp ubuntu dotenv common-aliases jira tig python zsh_reload autoenv mercurial lxd-completion kubectl sublime ali-aliases)
export PATH="/home/ali/bin:/snap/bin:$PATH"
source $ZSH/oh-my-zsh.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh
export VIRTUAL_ENV_DISABLE_PROMPT=0
unalias rm

