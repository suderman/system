# min

## Prepare Storage and Configuration Profiles

Prepare disks under the Storage tab:

| Label  | Type    | Size  | Device   |
| ------ | ------- | ----- | -------- |
| iso    | ext4    | 1024M | /dev/sdd |
| root   | ext4    | 1024M | /dev/sda |
| swap   | swap    | 2048M | /dev/sdb |
| nix    | raw     | -     | /dev/sdc |


Prepare two configurations under the Configurations tab:

| Label     | Kernel      | /dev/sda | /dev/sdb | /dev/sdc | /dev/sdd | Root Device |
| --------- | ----------- | -------- | -------- | -------- | -------- | ----------- |
| installer | Direct Disk | root     | swap     | nix      | iso      | /dev/sdd    |
| nixos     | GRUB 2      | root     | swap     | nix      | -        | /dev/sda    |

*Disable all Filesystem/Boot Helpers at the bottom!*

## Create NixOS installer

Boot node into Rescue Mode with `iso` mounted at `/dev/sdd`. Then launch a console:

```zsh
# https://nixos.org/download.html
iso=https://channels.nixos.org/nixos-22.11/latest-nixos-minimal-x86_64-linux.iso

# Download the ISO, write it to the installer disk, and verify the checksum:
curl -L $iso | tee >(dd of=/dev/sdd) | sha256sum
```

## Install NixOS

After the installer disk is created, boot the node with the `installer` profile. 
Then launch a console to install NixOS:

```zsh
sudo -s

# Personal computer
bash <(curl -sL https://github.com/suderman/nixos/raw/main/hosts/min/install.sh)

# Linode VPS
bash <(curl -sL https://github.com/suderman/nixos/raw/main/hosts/min/install.sh) LINODE
```