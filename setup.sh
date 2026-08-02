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

# --- install diff-so-fancy ---
if command -v diff-so-fancy >/dev/null 2>&1; then
    :
elif [ "$(uname)" = "Darwin" ]; then
    command -v brew >/dev/null 2>&1 && brew install diff-so-fancy
else
    # not packaged in apt; clone user-owned (no sudo, no dubious-ownership issues)
    mkdir -p "$HOME/bin"
    if [ ! -d "$HOME/.local/share/diff-so-fancy" ]; then
        git clone --branch next --depth 1 https://github.com/so-fancy/diff-so-fancy.git "$HOME/.local/share/diff-so-fancy"
    else
        git -C "$HOME/.local/share/diff-so-fancy" pull --ff-only
    fi
    ln -sf "$HOME/.local/share/diff-so-fancy/diff-so-fancy" "$HOME/bin/diff-so-fancy"
fi

# --- install lsd, jq (used by l/approve_pr/ipinfo fish functions) ---
if [ "$(uname)" = "Darwin" ]; then
    command -v brew >/dev/null 2>&1 && brew install lsd jq
elif [ -f /etc/debian_version ]; then
    sudo apt-get install -y lsd jq
fi

# --- bootstrap dotfiles bare repo ---
if [ -d "$HOME/.dotfiles" ]; then
    echo "~/.dotfiles already exists, pulling latest."
    git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" fetch
    RESET_REF=FETCH_HEAD
else
    git clone --bare https://github.com/alinik/dotfiles.git "$HOME/.dotfiles"
    RESET_REF=HEAD
fi
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" config --local --replace-all status.showUntrackedFiles no
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" reset --hard "$RESET_REF"
git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" submodule update --init --recursive

# --- fisher + plugins ---
"$FISH_BIN" -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update"

# --- local secrets template (never tracked in dotfiles) ---
if [ ! -f "$HOME/.config/fish/local.fish" ] && [ -f "$HOME/.config/fish/local.fish.example" ]; then
    cp "$HOME/.config/fish/local.fish.example" "$HOME/.config/fish/local.fish"
    chmod 600 "$HOME/.config/fish/local.fish"
    echo "Created ~/.config/fish/local.fish from template — fill in real secrets before using them."
fi

"$FISH_BIN" -c 'set -U fish_greeting ""'

# --- migrate zsh history to fish (one-time) ---
FISH_HISTORY="$HOME/.local/share/fish/fish_history"
if [ "$SHELL" != "$FISH_BIN" ] && [ -f "$HOME/.zsh_history" ] && [ ! -s "$FISH_HISTORY" ]; then
    echo "Migrating zsh history to fish..."
    mkdir -p "$(dirname "$FISH_HISTORY")"
    python3 - "$HOME/.zsh_history" "$FISH_HISTORY" <<'PYEOF'
import re
import sys
import pathlib

zsh_path, fish_path = sys.argv[1], sys.argv[2]
text = pathlib.Path(zsh_path).read_text(errors="ignore")

entries = []
buf = ""
for line in text.splitlines():
    buf = buf + "\n" + line if buf else line
    if buf.endswith("\\"):
        buf = buf[:-1]
        continue
    m = re.match(r"^: (\d+):(\d+);(.*)$", buf, re.S)
    if m:
        entries.append((int(m.group(1)), m.group(3)))
    elif buf.strip():
        entries.append((None, buf))
    buf = ""

def fish_escape(cmd):
    return cmd.replace("\\", "\\\\").replace("\n", "\\n")

with open(fish_path, "a") as f:
    for ts, cmd in entries:
        cmd = cmd.strip()
        if not cmd:
            continue
        f.write(f"- cmd: {fish_escape(cmd)}\n")
        f.write(f"  when: {ts if ts else 0}\n")
PYEOF
fi

if [ "$SHELL" != "$FISH_BIN" ]; then
    chsh -s "$FISH_BIN"
fi
exec "$FISH_BIN"
