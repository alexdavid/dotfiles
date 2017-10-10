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

# Load custom settings for current user
set local_settings_file ~/config.fish.local

set -x GOPATH ~/Development

if test -f $local_settings_file
   . $local_settings_file
end
