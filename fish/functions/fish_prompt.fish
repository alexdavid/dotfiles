function fish_prompt --description 'Write out the prompt'

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_normal
      set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __git_cb
      set __git_cb " ["(set_color green)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)"]"
  end

  if not set -q __fish_prompt_cwd
      set -g __fish_prompt_cwd (set_color $fish_color_cwd)
  end

  if set -q TMUX
    tmux setenv "TMUXPWD_"(tmux display -p "#D" | tr -d "%") (pwd)
  end

  printf '%s%s%s%s > ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
end
