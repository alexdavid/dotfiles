#########################################
# Path
#########################################
set -x PATH ~/.config/bin $PATH
set -x PATH $PATH ~/Development/go/bin


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
set -x GOPATH ~/Development/go
set -x PASSWORD_STORE_ENABLE_EXTENSIONS true


#########################################
# Etc
#########################################
set fish_greeting ""

function fish_title
  prompt_pwd
  echo -n " - Fish"
end

if [ (tty) = "/dev/tty1" ]
  sway -Dnoatomic
end

function g
  cd (find-project "$argv")
end
