set -x PATH ~/.bin ~/.rvm/bin /usr/local/bin /usr/local/share/npm/bin ~/.rvm/gems/ruby-1.9.3-p327/bin ./node_modules/.bin $PATH
set fish_greeting ""

function fish_title
  prompt_pwd
end

set -x PATH ~/.rbenv/shims $PATH
rbenv rehash
