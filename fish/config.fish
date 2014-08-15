# Set paths
set npm_bin (npm bin)
eval set -x PATH $npm_bin (~/.config/bin/get-paths)

# Set aliases
for val in (get-aliases " ")
  eval "alias $val"
end

set fish_greeting ""

function fish_title
  prompt_pwd
end

if which rbenv > /dev/null
  rbenv rehash
end

# Load custom settings for current user
set local_settings_file ~/config.fish.local

if test -f $local_settings_file
   . $local_settings_file
end
