#########################################
# Path
#########################################
set -x PATH \
  ~/.config/jail/bin \
  ~/.config/bin \
  /usr/local/sbin \
  /usr/local/bin \
  /usr/bin


#########################################
# Aliases
#########################################
# cd
alias ..  "cd .."
alias ... "cd ../.."

# git
alias gp  "git pull"
alias gpp "git pullpush"
alias gs  "git st"

# utilities
alias f "vifm ."
alias t "tmux"
alias v "nvim"
alias todol "todo list --sort priority,-due"

# clipboard
alias cbc "clipboard copy"
alias cbp "clipboard paste"

# macos
alias airport "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias ql      "quicklook"

# docker
alias dc   "docker-compose"
alias dcub "docker-compose up --build"

#########################################
# Env
#########################################
set -x EDITOR nvim
set -x BROWSER ~/.config/bin/browser
set -x GOPATH ~/Development/go
set -x PASSWORD_STORE_ENABLE_EXTENSIONS true
set -x BEMENU_OPTS "--ignorecase --list=10 --tb=#abb2bf --tf=#282c34 '--fn=SFNS Display 14' --nb=#333333 --hb=#abb2bf --hf=#282c34 --monitor=all"


#########################################
# Etc
#########################################
set fish_greeting ""

function fish_title
  prompt_pwd
  echo -n " - Fish"
end

function g
  cd (find-project "$argv")
end

function git_repo_is_clean
  if test ! -d $argv; return 0; end
  if ! git -C $argv diff-files --quiet; return 1; end
  set UPSTREAM (git -C $argv rev-parse --abbrev-ref --symbolic-full-name '@{u}')
  if test (git -C $argv rev-parse HEAD) = (git -C $argv rev-parse $UPSTREAM); return 0; end
  return 1
end

if ! git_repo_is_clean ~/.config
  set_color -b brred black -o
  echo ' * Dotfiles need sync * '
  set_color normal
end

if ! git_repo_is_clean ~/.password-store
  set_color -b brred black -o
  echo ' * Pass needs sync * '
  set_color normal
end

if [ (tty) = "/dev/tty1" ]
  exec sway
end
