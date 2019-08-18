# Applications

Holds `.desktop` files for application launchers on Linux. [The init script](init.sh)
symlinks this directory to `~/.local/share/applications` where launchers will pick them up.

The [.gitignore](.gitignore) in this dir acts as a whitelist allowing `.desktop` files
to be added to this directory without needing to commit them.
