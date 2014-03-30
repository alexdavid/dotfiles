if [ "$UNAME" = Darwin ]; then
  # add color to ls
  alias ls='ls -G'
  # add color to grep
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

