#!/bin/bash

# 1. Detect Distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        arch)   DISTRO_ICON="" ;;
        fedora) DISTRO_ICON="" ;;
        ubuntu) DISTRO_ICON="" ;;
        opensuse*)  DISTRO_ICON="" ;;
        *)      DISTRO_ICON="" ;;
    esac
else
    DISTRO_ICON=""
fi

# 2. Load Git Prompt (Local Copy)
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

# 3. Check if it's a container or not:
if [ -n "$CONTAINER_ID" ]; then
    box="$CONTAINER_ID"
else
    box="host"
fi

# 4. Configure Git Status
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

# 5. Define Colors
RESET="\[\e[0m\]"
GREEN="\[\e[32m\]"
BLUE="\[\e[34m\]"
CYAN="\[\e[36m\]"

# 6. Build PS1
# add $CONTAINER_ID somewhere here, if setting this in container
export PS1='('$CYAN''$DISTRO_ICON' '$RESET'['$box'])'$GREEN'\u'$RESET'@'$BLUE'\h'$RESET'[\w]$(__git_ps1 " (%s)")\n '
