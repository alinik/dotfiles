Setup:

```bash
git clone http://git.baregheh.com/scm/ext/ohmyzsh.git .oh-my-zsh
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
git clone --bare http://git.baregheh.com/scm/~nikneshan/dotfiles.git $HOME/.dotfiles
config config --local --add status.showUntrackedFiles no
config reset --hard

src
```

or

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare http://github.com/alinik/dotfiles.git $HOME/.dotfiles
config config --local --add status.showUntrackedFiles no
config reset --hard
```


