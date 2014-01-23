set -x PATH ~/.config/bin ~/.rbenv/shims /usr/local/bin /usr/local/share/npm/bin ./node_modules/.bin $PATH
set fish_greeting ""

function fish_title
  prompt_pwd
end

rbenv rehash
