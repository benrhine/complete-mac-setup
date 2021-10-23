#!/bin/sh
# ==============================================================================================================
# Unix / Linux command line utilities to install
# Some of these may be unnecessary but they are small and its nice to just get everything installed
# 
# Not currently included:
# - ssh-copy-id
# - memcached
# ==============================================================================================================
TERMINAL_UTILITIES=(
    ag
    ack
    autoconf
    automake
    fd
    ffind
    ffmpeg
    fpp
    gettext
    gifsicle
    graphviz
    hub
    imagemagick
    jq
    libjpeg
    libmemcached
    pkg-config
    rename
    terminal-notifier
    the_silver_searcher
    tmux
    tree
    vim
    watchman
    wget
    z
)

echo "Installing terminal utilitiy packages..."

for val in "${TERMINAL_UTILITIES[@]}"; do
    brew install $val || simpleError "$val"
done

echo "Terminal utilities installed"