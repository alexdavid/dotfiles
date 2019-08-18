# Docker

Changes docker's default detach of `^P ^Q` to `^G G`.
The default shortcut overrides `previous-history` in readline executables (like shells).

[The init script](init.sh) symlinks this directory to `~/.docker`

## TODO
* Add [pass credential helper](https://github.com/docker/docker-credential-helpers) so `docker login` does not dirty `config.json`
