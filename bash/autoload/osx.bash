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

