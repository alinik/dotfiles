Setup:

use:
```bash
wget -qO- https://raw.githubusercontent.com/alinik/dotfiles/master/setup.sh | bash
```


```bash
# install fish (Homebrew handles both Apple Silicon and Intel paths)
brew install fish

# register fish as a valid login shell
echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells

alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare http://github.com/alinik/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local --add status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME reset --hard

chsh -s "$(brew --prefix)/bin/fish"
fish

# install fisher (fish plugin manager)
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

# install plugins (reads ~/.config/fish/fish_plugins, already restored by dotfiles reset above)
fisher update

# secrets/local env are NOT tracked in dotfiles — restore separately
cp ~/.config/fish/local.fish.example ~/.config/fish/local.fish
chmod 600 ~/.config/fish/local.fish
# edit local.fish with real values, then:
source ~/.config/fish/config.fish
```
