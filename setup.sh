#!/bin/bash
set -e

# --- install fish ---
if command -v fish >/dev/null 2>&1; then
    :
elif [ "$(uname)" = "Darwin" ]; then
    command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install fish
elif [ -f /etc/debian_version ]; then
    sudo apt-get update
    sudo apt-add-repository -y ppa:fish-shell/release-4
    sudo apt-get update
    sudo apt-get install -y fish
else
    echo "Unsupported OS: install fish manually, then re-run this script." >&2
    exit 1
fi

FISH_BIN="$(command -v fish)"

# register fish as a valid login shell
grep -qxF "$FISH_BIN" /etc/shells || echo "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null

# --- bootstrap dotfiles bare repo ---
if [ -d "$HOME/.dotfiles" ]; then
    echo "~/.dotfiles already exists, pulling latest."
    git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" fetch
else
    git clone --bare https://github.com/alinik/dotfiles.git "$HOME/.dotfiles"
fi
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" reset --hard @{upstream}
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" submodule update --init --recursive

# --- fisher + plugins ---
"$FISH_BIN" -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update"

# --- local secrets template (never tracked in dotfiles) ---
if [ ! -f "$HOME/.config/fish/local.fish" ] && [ -f "$HOME/.config/fish/local.fish.example" ]; then
    cp "$HOME/.config/fish/local.fish.example" "$HOME/.config/fish/local.fish"
    chmod 600 "$HOME/.config/fish/local.fish"
    echo "Created ~/.config/fish/local.fish from template — fill in real secrets before using them."
fi

chsh -s "$FISH_BIN"
exec "$FISH_BIN"
