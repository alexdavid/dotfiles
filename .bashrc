UNAME=`uname -s`

case "$TERM" in xterm-color)
	color_prompt=yes;;
esac

# --------------------------------------
# ALIASES
# --------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias fn='find . -name'


# --------------------------------------
# Mac OS X SPECIFIC
# --------------------------------------

if [ "$UNAME" = Darwin ]; then
	# add color to ls
	alias ls='ls -G'

	export PATH=/opt/local/bin:/opt/local/sbin:$PATH
	color_prompt=yes
fi


# --------------------------------------
# Set PS1 
# --------------------------------------
if [ "$color_prompt" = yes ]; then
	PS1='\[\e[31m\](\[\e[m\]\u\[\e[31m\]@\h\[\e[m\]:\[\e[36m\]\W\[\e[31m\])\[\e[36m\]\$ \[\e[m\]'
else
	PS1='(\u@\h:\W)\$ '
fi
