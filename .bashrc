# If not running interactively, don't do anything
[ -z "$PS1" ] && return

UNAME=`uname -s`

# Source all files in the ~/.bash/ directory
for f in ~/.bash/*; do source $f; done

# Set PS1
PS1='(\u@\h:\W)\$ '
case "$TERM" in xterm-*color)
  PS1='\[\e[31m\](\[\e[m\]\u\[\e[31m\]@\h\[\e[m\]:\[\e[36m\]\W\[\e[31m\])\[\e[36m\]\$ \[\e[m\]'
esac


# check the window size after each command
shopt -s checkwinsize

# Add ~/.bin to path
export PATH=~/.bin:$PATH
export PATH=/usr/local/bin:$PATH

function g(){
  cd $* && ls
}

# set bash to VI mode
set -o vi
