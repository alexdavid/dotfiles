# Set paths
eval set -x PATH (~/.config/bin/get-paths)

# Set aliases
for val in (get-aliases " ")
  eval "alias $val"
end

set fish_greeting ""

function fish_title
  prompt_pwd
end

rbenv rehash
refresh-colors
