#!/bin/bash -i

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-contrib/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations,
# and if missing - will download a temporary copy that automatically get deleted at the end
# of the script
ensure_nanolayer nanolayer_location "v0.4.39"

SYNC_CONFIG_FROM_GIT_WEB_URL="${SYNC_CONFIG_FROM_GIT_WEB_URL:-""}"

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

git clone --depth 1 https://github.com/doomemacs/doomemacs ${_REMOTE_USER_HOME}/.emacs.d
mkdir ${_REMOTE_USER_HOME}/.doom.d
${_REMOTE_USER_HOME}/.emacs.d/bin/doom --doomdir ${_REMOTE_USER_HOME}/.doom.d install --force 
chown -R ${_REMOTE_USER}:${_REMOTE_USER} ${_REMOTE_USER_HOME}/.emacs.d ${_REMOTE_USER_HOME}/.doom.d

if [ ! -z "${SYNC_CONFIG_FROM_GIT_WEB_URL}" ]; then
    git clone "${SYNC_CONFIG_FROM_GIT_WEB_URL}" ${_REMOTE_USER_HOME}/.doom.d
    ${_REMOTE_USER_HOME}/.emacs.d/bin/doom sync
fi

echo 'Done!'
