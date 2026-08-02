if status is-interactive
    # Commands to run in interactive sessions can go here

    # fzf.fish: macOS-friendly pure-Ctrl binds (no Alt/Option-as-Meta needed)
    fzf_configure_bindings --directory=ctrl-g --git_log=ctrl-L --git_status=ctrl-k --history=ctrl-r --processes=ctrl-o --variables=ctrl-v

    # register PWD-hook for k8-user dir autoload (see functions/__k8user_autoload.fish)
    __k8user_autoload
end

# --- PATH (ported from .zshrc, priority order preserved: bun > antigravity > ~/bin group) ---
fish_add_path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /opt/homebrew/bin
fish_add_path "/Users/ali/Library/Application Support/hatch/pythons/3.13/python/bin"
fish_add_path -p $HOME/bin $HOME/.local/bin /snap/bin
fish_add_path -p /Users/ali/.antigravity/antigravity/bin
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path -p $BUN_INSTALL/bin

# kubetail plugin dir (binary + fish completion already in completions/)
fish_add_path $HOME/.oh-my-zsh/custom/plugins/kubetail

# --- env vars (ported from .zshrc) ---
set -gx BASH_MAX_OUTPUT_LENGTH 15000
set -gx VAULT_ADDR "https://keys.mybitmax.com"
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

# --- local machine secrets/env (ported from .zshrc_local) ---
if test -f $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

