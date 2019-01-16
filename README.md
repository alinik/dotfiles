Setup:

```bash
git clone http://git.baregheh.com/scm/ext/oh-my-zsh.git .oh-my-zsh
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
git clone --bare http://git.baregheh.com/scm/~nikneshan/dotfiles.git .dotfiles
config config --local --add status.showUntrackedFiles no
config reset --hard

src
```

