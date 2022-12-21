#!/bin/sh 
 
format_disk() {
  loadkeys br-abnt2
  lsblk 
  read -p "Select the disk: " -r DISK &&
  cfdisk "/dev/$DISK"
}

make_filesystem() {
  lsblk
  read -p "Root partition: " -r ROOT &&
  read -p "Boot Partition: " -r BOOT && 
  read -p "Filesystem: " -r FS &&
  mkfs.$FS $ROOT
  mkfs.fat -F 32 $BOOT
}

mount_fs() {
  mount $ROOT /mnt
  mount --mkdir $BOOT /mnt/boot
}

pacstrap_pkgs() {
  pacstrap -K /mnt base linux linux-firmware linux-headers linun-zen linux-zen-headers fish networkmanager nvim grub efibootmgr base-devel git curl
}

config_system() {
  genfstab -U /mnt >> /mnt/etc/fstab
  arch-chroot /mnt 
   ln -sf /usr/share/zoneinfo/America/Bahia /etc/localtime &&
     hwclock --systohc
   sed -i -e "/en_US.UTF-8 UTF-8/s/^#//" /etc/locale.gen 
   locale-gen
   touch /etc/locale.conf 
   echo "LANG=en_US.UTF-8" > /etc/locale.conf
   touch /etc/vconsole.conf 
   echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
   touch /etc/hostname 
   echo "archBTW" > /etc/hostname
   useradd -mG caue wheel 
   mkinitcpio -P
   passwd caue
}

grub_install() {
    grub-install --target=x86_64-efi --efi-directory=/boot --removable  --bootloader-id=archBT
    grub-mkconfig -o /boot/grub/grub.cfg
}

post_install() {
  cd /home/caue/
  curl https://raw.githubusercontent.com/EuCaue/dotfiles/main/installscripts/Arch/paru.sh | bash &&
  cd /home/caue/ 
  rm -rf /home/caue/paru/
  curl https://raw.githubusercontent.com/EuCaue/dotfiles/main/installscripts/Arch/wm.sh | bash &&
  git clone https://github.com/EuCaue/dotfiles
  exit 
  umount -R /mnt && sleep 5;
  reboot
}

format_disk &&
make_filesystem &&
mount_fs &&
pacstrap_pkgs &&
config_system &&
grub_install &&
post_install &&
