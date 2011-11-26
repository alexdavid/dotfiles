UNAME=`uname -s`


# --------------------------------------
# ALIASES
# --------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias fn='find . -name'


# --------------------------------------
# MAC OSX SPECIFIC
# --------------------------------------

if [ "$UNAME" = Darwin ]; then
	# add color to ls
	alias ls='ls -G'

	export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi


# --------------------------------------
# SET PS1 
# --------------------------------------

PS1='(\u@\h:\W)\$ '
case "$TERM" in xterm-*color)
	PS1='\[\e[31m\](\[\e[m\]\u\[\e[31m\]@\h\[\e[m\]:\[\e[36m\]\W\[\e[31m\])\[\e[36m\]\$ \[\e[m\]'
esac


