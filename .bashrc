UNAME=`uname -s`




# --------------------------------------
# Mac OS X SPECIFIC
# --------------------------------------

if [ "$UNAME" = Darwin ]; then
	# add color to ls
	alias ls='ls -G'
fi
