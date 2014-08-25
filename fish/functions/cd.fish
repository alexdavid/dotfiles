function cd
  builtin cd $argv
  emit cwd
end

function __npm_cwd --on-event cwd
  set old_npm_bin $npm_bin
  set npm_bin (npm bin)

  for i in (seq (count $PATH))
    switch $PATH[$i]
      case $old_npm_bin
        if test -d $npm_bin
          set PATH[$i] $npm_bin
        end
    end
  end
end
