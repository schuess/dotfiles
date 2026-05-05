# dotfiles

Personal shell / editor / Hammerspoon config. Symlink farm — no
proprietary tool, just plain git plus a tiny installer.

## Install on a fresh machine

```
curl -L sch.us/setup.sh | sh
```

(Or, without the redirect: `curl -fsSL https://raw.githubusercontent.com/schuess/dotfiles/main/install.sh | sh`.)

`install.sh` clones this repo to `~/.dotfiles` and symlinks every
entry under `files/` into `$HOME`. Pre-existing files are backed up
with a `.backup.<timestamp>` suffix. Idempotent — re-run safely.

Two things `install.sh` doesn't do:

- **Doesn't install git** — needs to be there already (usually is on
  macOS after the first `git` invocation triggers the Xcode CLT
  install).
- **Doesn't create `~/.zshrc.local`.** If the new machine needs the
  Delta creds (or any other secrets), write that file by hand after
  install — otherwise `.zshrc` sources it conditionally and just
  skips it.

`install.sh` clones via HTTPS (no auth needed for a public repo).
But `dotsync` from the new machine will try to push via the same
HTTPS URL — that needs auth. If you want to push from the new
machine, either switch `origin` to the SSH URL after install:

```
git -C ~/.dotfiles remote set-url origin git@github.com:schuess/dotfiles.git
```

…or set up a GitHub PAT for HTTPS.

## Per-machine secrets

Anything secret or machine-specific lives in `~/.zshrc.local` (mode
`600`, never tracked here). The tracked `.zshrc` ends with:

```
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
```

Create it by hand on each new machine. Example contents:

```
export DELTA_DENTAL_USERNAME='...'
export DELTA_DENTAL_PASSWORD='...'
export ANTHROPIC_API_KEY='sk-ant-...'
```

## Sync changes back

Edits made to any tracked file (via the `$HOME` symlink) land in the
repo because the symlinks point at `files/.*`. To commit + push:

```
dotsync                  # default message "sync"
dotsync "tweak prompt"   # custom message
```

`dotsync` is defined in the tracked `.zshrc`.

## Adding a new file to track

Say you want to start tracking `~/.tmux.conf`:

```
mv ~/.tmux.conf ~/.dotfiles/files/.tmux.conf
ln -s ~/.dotfiles/files/.tmux.conf ~/.tmux.conf
dotsync "track .tmux.conf"
```

Or, if the file doesn't exist yet, create it directly under
`~/.dotfiles/files/` and then `ln -s` it into `$HOME`. Re-running
`install.sh` on other machines will pick it up automatically (because
the loop walks every entry in `files/`).

For a directory (like `.hammerspoon` was), do the same — `mv` it in,
then `ln -s` the whole directory. `install.sh` symlinks dirs and
files identically.

## What's tracked

Symlinked into `$HOME` by `install.sh`:

- `.zshrc`, `.zshenv`, `.zprofile`
- `.gitconfig`
- `.vimrc`
- `.hammerspoon/` (whole directory — init.lua + assets + Spoons)

Tracked but not symlinked (manual import on a new machine):

- `prefs/Actions.moom` — Moom snap actions. Update with **File →
  Export** in Moom; import with **File → Import** on a new machine.

## What's deliberately not tracked

- `.ssh/`, `.aws/`, `.docker/`, shell history files
- `.config/op/`, `.claude/`, `.vscode/` — too account-specific
- Homebrew / app installs — handled separately
