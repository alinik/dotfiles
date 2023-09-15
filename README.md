Setup:


```bash
wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --unattended && rm install.sh
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare http://github.com/alinik/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local --add status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME reset --hard
chsh -s /bin/zsh
zsh
```

