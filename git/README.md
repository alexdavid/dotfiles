# Git

Contains my git configuration

## Init

[The init script](init.sh) prompts for name and email for commits and stores
them in the gitignored `gitconfig_user`, which is included at the bottom of
[config](config).

No symlinking is required because git already looks for a config file in
`~/.config/git/config`
