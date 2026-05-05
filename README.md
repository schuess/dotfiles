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

## What's tracked

- `.zshrc`, `.zshenv`, `.zprofile`
- `.gitconfig`
- `.vimrc`
- `.hammerspoon/` (whole directory — init.lua + assets + Spoons)

## What's deliberately not tracked

- `.ssh/`, `.aws/`, `.docker/`, shell history files
- `.config/op/`, `.claude/`, `.vscode/` — too account-specific
- Homebrew / app installs — handled separately
