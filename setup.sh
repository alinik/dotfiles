#!/bin/bash
set -e

install_optional() {
    if ! "$@"; then
        echo "Warning: optional installation failed: $*; continuing setup." >&2
    fi
}

# --- install fish ---
MIN_FISH_VERSION="3.7.0"

fish_version_ok() {
    command -v fish >/dev/null 2>&1 || return 1
    CUR_FISH_VERSION="$(fish --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
    [ "$(printf '%s\n%s' "$MIN_FISH_VERSION" "$CUR_FISH_VERSION" | sort -V | head -1)" = "$MIN_FISH_VERSION" ]
}

if fish_version_ok; then
    :
elif [ "$(uname)" = "Darwin" ]; then
    command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if command -v fish >/dev/null 2>&1; then
        brew upgrade fish
    else
        brew install fish
    fi
elif [ -f /etc/debian_version ]; then
    sudo apt-get update
    sudo apt-add-repository -y ppa:fish-shell/release-4
    sudo apt-get update
    sudo apt-get install -y fish
else
    echo "Unsupported OS: install fish manually, then re-run this script." >&2
    exit 1
fi

if ! fish_version_ok; then
    echo "Warning: fish version still below $MIN_FISH_VERSION after install/upgrade attempt." >&2
fi

FISH_BIN="$(command -v fish)"

# register fish as a valid login shell
grep -qxF "$FISH_BIN" /etc/shells || echo "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null

# --- install diff-so-fancy ---
if command -v diff-so-fancy >/dev/null 2>&1; then
    :
elif [ "$(uname)" = "Darwin" ]; then
    command -v brew >/dev/null 2>&1 && install_optional brew install diff-so-fancy
else
    # not packaged in apt; clone user-owned (no sudo, no dubious-ownership issues)
    mkdir -p "$HOME/bin"
    if [ ! -d "$HOME/.local/share/diff-so-fancy" ]; then
        install_optional git clone --branch next --depth 1 https://github.com/so-fancy/diff-so-fancy.git "$HOME/.local/share/diff-so-fancy"
    else
        install_optional git -C "$HOME/.local/share/diff-so-fancy" pull --ff-only
    fi
    if [ -f "$HOME/.local/share/diff-so-fancy/diff-so-fancy" ]; then
        ln -sf "$HOME/.local/share/diff-so-fancy/diff-so-fancy" "$HOME/bin/diff-so-fancy"
    fi
fi

# --- install optional CLI tools used by Fish functions ---
if [ "$(uname)" = "Darwin" ]; then
    command -v lsd >/dev/null 2>&1 || install_optional brew install lsd
    command -v jq >/dev/null 2>&1 || install_optional brew install jq
    command -v bat >/dev/null 2>&1 || install_optional brew install bat
    command -v rg >/dev/null 2>&1 || install_optional brew install ripgrep
    command -v fd >/dev/null 2>&1 || install_optional brew install fd
elif [ -f /etc/debian_version ]; then
    DEBIAN_PACKAGES=()
    command -v jq >/dev/null 2>&1 || DEBIAN_PACKAGES+=(jq)
    command -v batcat >/dev/null 2>&1 || DEBIAN_PACKAGES+=(bat)
    command -v rg >/dev/null 2>&1 || DEBIAN_PACKAGES+=(ripgrep)
    command -v fdfind >/dev/null 2>&1 || DEBIAN_PACKAGES+=(fd-find)
    if [ "${#DEBIAN_PACKAGES[@]}" -gt 0 ]; then
        install_optional sudo apt-get update
        install_optional sudo apt-get install -y "${DEBIAN_PACKAGES[@]}"
    fi
    if ! command -v lsd >/dev/null 2>&1; then
        # not packaged on Ubuntu <24.04; install from upstream .deb release
        LSD_VER="1.2.0"
        LSD_ARCH="$(dpkg --print-architecture)"
        if curl --connect-timeout 5 --max-time 20 -sLo /tmp/lsd.deb "https://github.com/lsd-rs/lsd/releases/download/v${LSD_VER}/lsd_${LSD_VER}_${LSD_ARCH}.deb"; then
            install_optional sudo dpkg -i /tmp/lsd.deb
        else
            echo "Warning: optional lsd download failed (no GitHub access?); continuing setup." >&2
        fi
        rm -f /tmp/lsd.deb
    fi
fi

# --- bootstrap dotfiles bare repo ---
DOTFILES_GIT="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
DOTFILES_ALREADY_EXISTS=false
if [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_ALREADY_EXISTS=true
    echo "~/.dotfiles already exists, pulling latest."
    $DOTFILES_GIT fetch
    RESET_REF=FETCH_HEAD
else
    git clone --bare https://github.com/alinik/dotfiles.git "$HOME/.dotfiles"
    RESET_REF=HEAD
fi
$DOTFILES_GIT config --local --replace-all status.showUntrackedFiles no

# Before checking out the authoritative version committed in dotfiles,
# back up a differing local key file (covers first install, stale
# ~/.dotfiles, and the "repo just started tracking it" transition).
# Repo always wins — this backup is a safety net only, not a prompt.
if [ -f "$HOME/.ssh/authorized_keys" ] \
    && $DOTFILES_GIT cat-file -e "$RESET_REF:.ssh/authorized_keys" 2>/dev/null \
    && ! $DOTFILES_GIT cat-file -p "$RESET_REF:.ssh/authorized_keys" | cmp -s - "$HOME/.ssh/authorized_keys"; then
    AUTHORIZED_KEYS_BACKUP="$HOME/.ssh/authorized_keys.before-dotfiles.$(date +%Y%m%dT%H%M%S)"
    cp "$HOME/.ssh/authorized_keys" "$AUTHORIZED_KEYS_BACKUP"
    echo "Backed up existing ~/.ssh/authorized_keys to $AUTHORIZED_KEYS_BACKUP (differs from incoming dotfiles version); repo version will be used."
fi
$DOTFILES_GIT reset --hard "$RESET_REF"
if [ -f "$HOME/.ssh/authorized_keys" ]; then
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh/authorized_keys"
fi

# --- SSH control socket directory ---
mkdir -p "$HOME/.ssh/sockets"

# --- iTerm2 shell integration (install on local and SSH hosts) ---
# The installer picks which shell's integration file to write based on
# $SHELL. Force it to fish here — otherwise, on a box not yet chsh'd to
# fish, it only writes the .zsh file and this step re-downloads every run.
if [ ! -f "$HOME/.iterm2_shell_integration.fish" ]; then
    if ! curl --connect-timeout 5 --max-time 20 -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | SHELL="$FISH_BIN" bash; then
        echo "Warning: optional iTerm2 integration installation failed; continuing setup." >&2
    fi
fi

# --- fisher + plugins ---
if [ -f "$HOME/.config/fish/functions/fisher.fish" ]; then
    FISHER_CMD="fisher update"
else
    FISHER_CMD="curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update"
fi

FISHER_TRIES=0
FISHER_MAX_TRIES=3
# stdin starved deliberately: when setup.sh itself is run via `curl|bash` /
# `wget -qO-|bash`, fd 0 is the pipe carrying the REST of this script.
# Fisher reads stdin internally; without </dev/null it drains that pipe and
# the remainder of setup.sh gets fed to fisher as garbage plugin names.
until "$FISH_BIN" -c "$FISHER_CMD" < /dev/null; do
    FISHER_TRIES=$((FISHER_TRIES + 1))
    if [ "$FISHER_TRIES" -ge "$FISHER_MAX_TRIES" ]; then
        echo "Warning: optional Fisher plugin installation failed after $FISHER_MAX_TRIES tries (rate limit?); continuing setup." >&2
        break
    fi
    echo "Fisher install/update failed, retry $FISHER_TRIES/$FISHER_MAX_TRIES in 30s..." >&2
    sleep 30
done

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

CURRENT_LOGIN_SHELL="$(dscl . -read "$HOME" UserShell 2>/dev/null | awk '{print $2}')"
[ -n "$CURRENT_LOGIN_SHELL" ] || CURRENT_LOGIN_SHELL="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
if [ "$CURRENT_LOGIN_SHELL" != "$FISH_BIN" ]; then
    chsh -s "$FISH_BIN"
fi
exec "$FISH_BIN"
