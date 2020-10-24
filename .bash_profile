#!/usr/bin/env bash
source ~/.bashrc
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
