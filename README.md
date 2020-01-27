Setup:

```bash
git clone http://git.baregheh.com/scm/ext/oh-my-zsh.git .oh-my-zsh
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
git clone --bare http://git.baregheh.com/scm/~nikneshan/dotfiles.git .dotfiles
config config --local --add status.showUntrackedFiles no
config reset --hard

src
```

or

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare http://github.com/alinik/dotfiles.git .dotfiles
config config --local --add status.showUntrackedFiles no
config reset --hard
```


