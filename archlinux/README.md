# Archlinux

Contains [PKGBUILD](https://wiki.archlinux.org/index.php/PKGBUILD) and setup scripts for new
Archlinux installs on my machines. The PKGBUILD packages are
[meta packages](https://wiki.archlinux.org/index.php/Package_group#Difference_to_a_meta_package)
that I use to get all the base tools I need to get up and running on a new install.

## Setup
Initial setup scripts are in the [setup](setup) directory

## Init
[The init script](init.sh) takes a suffix of the PKGBUILD file to run

For example:
```shell
$ ./init.sh shared
```
will install all dependencies in the PKGBUILD-shared file.
