#!/bin/bash -i

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-contrib/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations,
# and if missing - will download a temporary copy that automatically get deleted at the end
# of the script
ensure_nanolayer nanolayer_location "v0.4.39"

DOOM_EMACS_USER="${DOOM_EMACS_USER:-"vscode"}"
DOOM_EMACS_USER_HOME="${DOOM_EMACS_USER_HOME:-"/home/vscode"}"

$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-contrib/features/homebrew-package:1.0.7" \
    --option package='emacs'

$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-contrib/features/homebrew-package:1.0.7" \
    --option package='git'

export PATH=$PATH:/home/linuxbrew/.linuxbrew/opt/emacs/bin

git clone --depth 1 https://github.com/doomemacs/doomemacs ${DOOM_EMACS_USER_HOME}/.config/emacs
mkdir -p ${DOOM_EMACS_USER_HOME}/.config/doom
${DOOM_EMACS_USER_HOME}/.config/emacs/bin/doom --doomdir ${DOOM_EMACS_USER_HOME}/.config/doom install --force 

chown -R ${DOOM_EMACS_USER}:${DOOM_EMACS_USER} ${DOOM_EMACS_USER_HOME}/.config/emacs ${DOOM_EMACS_USER_HOME}/.config/doom

echo 'Done!'
