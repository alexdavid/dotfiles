# My archlinux setup scripts

```shell
wget https://raw.githubusercontent.com/alexdavid/dotfiles/master/archlinux/setup/init
bash init
arch-chroot /mnt
```
Add `encrypt` to `/etc/mkinitcpio.conf` hooks:
```
HOOKS="base udev autodetect block encrypt filesystems keyboard fsck"
```

```shell
mkinitcpio -p linux
wget https://raw.githubusercontent.com/alexdavid/dotfiles/master/archlinux/setup/chroot
bash chroot

# optional if wifi-menu is needed after reboot:
pacman -S sudo dialog wpa_supplicant

exit
umount /mnt/boot
umount /mnt
cryptsetup close main
reboot
```
