#!/bin/sh
# vim: set ft=sh :

set -eu
cd "$(dirname "$0")"

. .setup.lib.sh

log_info 'Installing some dotfiles.'

# Prezto
github_clone_if_not_exists sorin-ionescu/prezto "${ZDOTDIR:-$HOME}/.zprezto"
RCFILES=$(find "${ZDOTDIR:-$HOME}"/.zprezto/runcoms -type f -name 'z*')
for rcfile in ${RCFILES}
do
  ln -snf "${rcfile}" "${ZDOTDIR:-$HOME}/.${rcfile##*/}"
done

# zsh.d
ln -snf .zsh.d "${ZDOTDIR:-$HOME}/.zsh.d"

# Update scripts
mkdir -p "${HOME}/bin"
for f in "$(pwd)/bin/"*
do
  ln -snf "${f}" "${HOME}/bin/$(basename "${f}")"
done

# NanoRC dotfiles
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

# My dotfiles
MY_REPOS="${HOME}/src/my"
DOTFILES="${MY_REPOS}/dotfiles"
mkdir -p "${MY_REPOS}"
github_clone_if_not_exists kurone-kito/dotfiles "${DOTFILES}"

"${DOTFILES}/setup"
