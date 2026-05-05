#!/bin/sh
# curl -L sch.us/setup.sh | sh
#
# Clones the dotfiles repo (or pulls if it exists) and symlinks every
# entry under files/ into $HOME, backing up any existing real file.
set -eu

REPO_URL="${DOTFILES_REPO:-https://github.com/schuess/dotfiles.git}"
DEST="${DOTFILES_DIR:-$HOME/.dotfiles}"
TS="$(date +%Y%m%d-%H%M%S)"

if [ ! -d "$DEST" ]; then
  git clone "$REPO_URL" "$DEST"
else
  git -C "$DEST" pull --ff-only
fi

# Symlink every file/dir under files/ into $HOME. Skip if already linked
# to the same target; back up any real file standing in the way.
for src in "$DEST"/files/.*; do
  name="$(basename "$src")"
  case "$name" in . | ..) continue ;; esac
  dest="$HOME/$name"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    continue
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.backup.$TS"
    echo "backed up $dest -> $dest.backup.$TS"
  fi
  ln -s "$src" "$dest"
  echo "linked    $dest -> $src"
done

cat <<'NOTE'

Done. If you have machine-local env (DELTA_DENTAL_*, API keys, etc),
create ~/.zshrc.local with those exports and chmod 600 it -- .zshrc
sources it on shell startup but it stays out of the dotfiles repo.
NOTE
