eval set -x PATH (~/.config/bin/get-paths)

set fish_greeting ""

function fish_title
  prompt_pwd
end

rbenv rehash
refresh-colors
