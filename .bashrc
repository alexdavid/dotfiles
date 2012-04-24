# If not running interactively, don't do anything
[ -z "$PS1" ] && return

UNAME=`uname -s`


# --------------------------------------
# ALIASES
# --------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias fn='find . -name'
alias ..='cd ..'
alias gg='cd .. && ls'

# I prefer grep colors to boring pgrep
alias pgrep='ps -efM | grep'


# --------------------------------------
# LS AND GREP COLORS
# --------------------------------------
if [ -x /usr/bin/dircolors ]; then
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi


# --------------------------------------
# GIT SHORTCUTS & COLORS
# --------------------------------------
git config alias.co checkout
git config alias.st status
git config alias.ci commit
git config alias.br branch

git config color.ui true


# --------------------------------------
# MAC OSX SPECIFIC
# --------------------------------------
if [ "$UNAME" = Darwin ]; then
	# add color to ls
	alias ls='ls -G'
	# add color to grep
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'

	export PATH=/opt/local/bin:/opt/local/sbin:$PATH

	# Quicklook from terminal
	function ql ()
	{
		(qlmanage -p "$@" > /dev/null 2>&1 &
		local ql_pid=$!
		read -sn 1
		kill ${ql_pid}) > /dev/null 2>&1
	}
fi


# --------------------------------------
# SET PS1 
# --------------------------------------
PS1='(\u@\h:\W)\$ '
case "$TERM" in xterm-*color)
	PS1='\[\e[31m\](\[\e[m\]\u\[\e[31m\]@\h\[\e[m\]:\[\e[36m\]\W\[\e[31m\])\[\e[36m\]\$ \[\e[m\]'
esac


# --------------------------------------
# HISTORY
# --------------------------------------
# don't put duplicate lines in the history.
HISTCONTROL=ignoredups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000


# --------------------------------------
# ETC
# --------------------------------------
# check the window size after each command
shopt -s checkwinsize

# Add ~/.bin to path
export PATH=~/.bin:$PATH

# Source git-completion
source ~/.bash/git-completion.bash

function g(){
	cd $* && ls
}

set -o vi
