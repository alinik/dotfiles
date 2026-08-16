# Dotfiles

Install or refresh this Fish-based environment with:

```bash
wget -qO- https://raw.githubusercontent.com/alinik/dotfiles/master/setup.sh | bash
```

The installer supports macOS and Debian/Ubuntu. It installs Fish, configures
the bare dotfiles repository, optional command-line tools and Fisher plugins,
then switches the login shell to Fish.

## What setup preserves

- Existing local dotfile changes on a rerun are stashed before the checkout.
  Recover them with:

  ```bash
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" stash pop
  ```

- On a first install, an existing `~/.ssh/authorized_keys` is saved as
  `~/.ssh/authorized_keys.before-dotfiles.<timestamp>`, then the version
  committed in dotfiles is checked out. Keep the active SSH session open and
  test a new login before deleting that backup.

- `~/.config/fish/local.fish` is not tracked. Setup creates it from
  `local.fish.example` when needed; add machine-local secrets there.

## Updating dotfiles

The repository is bare, with `$HOME` as its work tree:

```bash
# In Fish, after setup:
config pull --ff-only

# In any shell:
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" pull --ff-only
```

The Fish startup update check refreshes dotfiles and Fisher at most once every
seven days. If an existing server has an untracked `authorized_keys` file,
back it up before the first pull so the committed version can be checked out:

```bash
mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.before-dotfiles
config pull --ff-only
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Included tools

Optional tooling includes `diff-so-fancy`, `lsd`, `jq`, `bat`/`batcat`,
Ripgrep, and `fd`/`fdfind`. Failed optional installations print a warning and
do not stop setup.
