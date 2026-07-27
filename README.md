Setup:

use:
```bash
wget -qO- https://raw.githubusercontent.com/alinik/dotfiles/master/setup.sh | bash
```

That script (`setup.sh`) does everything below automatically — install fish (macOS via brew, Ubuntu/Debian via apt PPA), clone the dotfiles bare repo, install fisher + plugins, seed `local.fish` from template, switch shell. Manual steps, if you want to do it by hand:


```bash
# --- install fish ---
# macOS:
brew install fish
# Ubuntu/Debian:
sudo apt-add-repository -y ppa:fish-shell/release-3 && sudo apt-get update && sudo apt-get install -y fish

FISH_BIN="$(command -v fish)"

# register fish as a valid login shell
echo "$FISH_BIN" | sudo tee -a /etc/shells

# --- bootstrap dotfiles bare repo ---
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/alinik/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local --add status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME reset --hard

chsh -s "$FISH_BIN"
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
