# HACK: WIP 

#!/bin/sh 
 
format_disk() {
  echo "Keyboard layout: " &&
  read -r kb &&
  loadkeys $kb &&
  lsblk &&
  read -p "Select the disk (e.g sda): " -r DISK &&
  cfdisk "/dev/$DISK" 
}

make_filesystem() {
  lsblk &&
  read -p "Root partition: (e.g: sda1) " -r ROOT &&
  read -p "Boot Partition: (e.g: sda2)" -r BOOT && 
  mkfs.ext4 "/dev/$DISK/$ROOT" &&
  mkfs.fat -F 32 "/dev/$DISK/$BOOT" 
}

mount_fs() {
  mount /dev/$DISK/$ROOT /mnt &&
  mount --mkdir /dev/$DISK/$BOOT /mnt/boot 
} 

pacstrap_pkgs() {
  pacstrap -K /mnt base linux linux-firmware linux-headers linun-zen linux-zen-headers fish networkmanager nvim grub efibootmgr base-devel git curl 
}

config_system() {
  genfstab -U /mnt >> /mnt/etc/fstab &&
  arch-chroot /mnt && 
   ln -sf /usr/share/zoneinfo/America/Bahia /etc/localtime &&
     hwclock --systohc &&
   sed -i -e "/en_US.UTF-8 UTF-8/s/^#//" /etc/locale.gen && 
   locale-gen &&
   touch /etc/locale.conf && 
   echo "LANG=en_US.UTF-8" > /etc/locale.conf &&
   touch /etc/vconsole.conf && 
   echo "KEYMAP=br-abnt2" > /etc/vconsole.conf &&
   touch /etc/hostname && 
   echo "archBTW" > /etc/hostname &&
   read -p "Username (UNIX): " -r username &&
   useradd -mG $username wheel&& 
   mkinitcpio -P &&
   passwd $username  
}

grub_install() {
    grub-install --target=x86_64-efi --efi-directory=/boot --removable  --bootloader-id=archBT &&
    grub-mkconfig -o /boot/grub/grub.cfg
}

post_install() {
  cd /home/$username/ &&
  curl https://raw.githubusercontent.com/EuCaue/dotfiles/main/installscripts/Arch/paru.sh | bash &&
  cd /home/caue/  &&
  rm -rf /home/$username/paru/ &&
  curl https://raw.githubusercontent.com/EuCaue/dotfiles/main/installscripts/Arch/wm.sh | bash &&
  git clone https://github.com/EuCaue/dotfiles &&
  exit && 
  umount -a && sleep 2 &&
  reboot
}

format_disk 
make_filesystem 
mount_fs 
pacstrap_pkgs 
config_system 
grub_install 
post_install 
