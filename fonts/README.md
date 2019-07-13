# Fonts

Contains fonts used for my systems in [the dist directory](dist).


## Init
[The init script](init.sh) symlinks [the dist directory](dist) to `~/.fonts` where Linux can pick them up.


## Src
[The src directory](src) contains the source and build script for my custom icon font [dist/icons.ttf](dist/icons.ttf).

[src/generate](src/generate) compiles all the svgs found in [src/config.json](src/config.json)
into the icon font using [fontello](https://github.com/paulyoung/fontello-cli).

This allows me to use any SVG for an icon for things like i3bar, vim, etc... instead of being forced to choose from an existing
icon pack like fontawesome.
