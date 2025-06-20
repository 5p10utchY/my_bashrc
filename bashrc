# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    	# We have color support; assume it's compliant with Ecma-48
    	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    	# a case would tend to support setf rather than setaf.)
    	color_prompt=yes
        else
    	color_prompt=
    fi
fi

##
##-- PROMPT --
##

## PROMPT COLOURS
#BLACK='\e[0;30m'      # Black - Regular
#RED='\e[0;31m'        # Red
#GREEN='\e[0;32m'      # Green
#YELLOW='\e[0;33m'     # Yellow
#BLUE='\e[0;34m'       # Blue
#PURPLE='\e[0;35m'     # Purple
#CYAN='\e[0;36m'       # Cyan
#WHITE='\e[0;37m'      # White
#BLACK_BOLD='\e[1;30m'   # Black - Bold
#RED_BOLD='\e[1;31m'     # Red - Bold
#GREEN_BOLD='\e[1;32m'   # Green - Bold
#YELLOW_BOLD='\e[1;33m'  # Yellow - Bold
#BLUE_BOLD='\e[1;34m'    # Blue - Bold
#PURPLE_BOLD='\e[1;35m'  # Purple - Bold
#CYAN_BOLD='\e[1;36m'    # Cyan - Bold
#WHITE_BOLD='\e[1;37m'   # White - Bold
#RESET='\e[0m'         # Text Reset


parse_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

##-- Ajout Openstack d'Infomaniak
## like git ps1 for openstack
__openstack_ps1()
{
    if [ -n "$OS_PROJECT_NAME" ] && [ -n "$OS_PASSWORD" ]; then
        (echo $OS_AUTH_URL | grep -q infomaniak.cloud) && local cluster=$(echo $OS_AUTH_URL | sed 's/.*api.\([^ ]*\).infomaniak.*/\1/')
        [ -z "$cluster" ] && cluster="openstack"
        printf -- "%s" " ($cluster|$OS_PROJECT_NAME)"
    fi
}
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\[\e[38;5;208m\]$(__openstack_ps1)\[\e[38;5;2m\]$([ -n "$(parse_git_branch)" ] && echo " ($(parse_git_branch))")\[\e[38;1;2m\]\$\[\e[0m\] '
##-- fin ajoute Openstack d'Infomaniak

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$([ -n "$(parse_git_branch)" ] && echo " ($(parse_git_branch))") \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$([ -n "$(parse_git_branch)" ] && echo " ($(parse_git_branch))") \$ '
fi

##--- Ajout de Parrot OS ---
#if [ "$color_prompt" = yes ]; then
#    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\[\033[01;33m\]$(__openstack_ps1)$([ -n "$(parse_git_branch)" ] && echo " ($(parse_git_branch))")\[\e[38;5;2m\]\[\033[0;39m\] \n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\] "
#else
#    PS1='\e[0m┌──[\u@\h]─[\w]$(__openstack_ps1)$([ -n "$(parse_git_branch)" ] && echo " ($(parse_git_branch))")\n└──╼ \$ '
#fi

# Set 'man' colors
#if [ "$color_prompt" = yes ]; then
#	man() {
#	env \
#	LESS_TERMCAP_mb=$'\e[01;31m' \
#	LESS_TERMCAP_md=$'\e[01;31m' \
#	LESS_TERMCAP_me=$'\e[0m' \
#	LESS_TERMCAP_se=$'\e[0m' \
#	LESS_TERMCAP_so=$'\e[01;44;33m' \
#	LESS_TERMCAP_ue=$'\e[0m' \
#	LESS_TERMCAP_us=$'\e[01;32m' \
#	man "$@"
#	}
#fi
##--- fin ajout de Parrot OS ---

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases.sh ]; then
    . ~/.bash_aliases.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
