# GTK 3.0

Adds emacs-style readline bindings to GTK 3 apps similar to how
[my keybindings repo](https://github.com/alexdavid/keybindings)
adds emacs bindings to MacOS.

Some applications like Firefox, however, don't take affect
until `org.gnome.desktop.interface` is also set through
`gsettings`. So [the init script](init.sh) sets that.

I haven't figured out any way to set this statically
through `settings.ini`, unfortunately.
