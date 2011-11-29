UNAME=`uname -s`


# --------------------------------------
# ALIASES
# --------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias fn='find . -name'
alias ..='cd ..'


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
