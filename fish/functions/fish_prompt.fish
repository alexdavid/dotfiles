set __last_color black

function __prompt_section
  set_color -b $argv[1] $__last_color
   printf ""
  set __last_color $argv[1]
  set_color $argv[2]
  printf " $argv[3..-1] "
end

function __end_prompt_sections
  set_color -b normal $__last_color
   printf ""
  set_color normal
  printf " "
end

function fish_prompt
  set cmd_status $status
  set __last_color black
  if test -n "$SSH_CLIENT" -o -n "$SSH_TTY" -o "$HOME" != "/home/$USER"
    __prompt_section blue black (whoami)@(cat /etc/hostname)
  end

  set cwd (prompt_pwd)
  set parent_dir (dirname $cwd)
  set current_dir (basename $cwd)
  if test $parent_dir != . -a $parent_dir != /;
    __prompt_section brblack white $parent_dir
  end
  __prompt_section green black $current_dir

  if git rev-parse --git-dir > /dev/null 2>&1
    __prompt_section yellow black  (git rev-parse --abbrev-ref HEAD 2> /dev/null)
  end

  if test $cmd_status -ne 0
    __prompt_section brred black $cmd_status
  end

  if test (id -u) -eq 0
    __prompt_section 553333 white "#"
  end

  __end_prompt_sections
end
