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
pacman -S wget sudo git binutils
wget https://raw.githubusercontent.com/alexdavid/dotfiles/master/archlinux/setup/chroot
bash chroot

# optional if wifi-menu is needed after reboot:
pacman -S dialog wpa_supplicant

exit
umount /mnt/boot
umount /mnt
cryptsetup close main
reboot
```
