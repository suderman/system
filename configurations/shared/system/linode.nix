# https://www.linode.com/docs/guides/install-nixos-on-linode/
{ config, lib, pkgs, ... }:

let 
  cfg = config.hardware.linode;

in {
  options = {
    hardware.linode.enable = lib.options.mkEnableOption "linode"; 
  };

  # hardware.linode.enable = true;
  config = lib.mkIf cfg.enable {

    # Enable LISH for Linode
    boot.kernelParams = [ "console=ttyS0;19200n8" ];
    boot.loader.grub.extraConfig = ''
      serial --speed=19200 --unit=0 --word=8 --parity=non --stop=1;
      terminal_input serial;
      terminal_output serial
    '';

    # Configure GRUB for Linode
    boot.loader.grub.forceInstall = true;
    boot.loader.grub.device = "nodev";
    boot.loader.timeout = 10;

    # Disable predictable interface names for Linode
    networking.usePredictableInterfaceNames = false;
    networking.useDHCP = false; # Disable DHCP globally as we will not need it.
    networking.interfaces.eth0.useDHCP = true;

    # IPv6 is broken when trying to reach CloudFlare DNS
    networking.enableIPv6 = false;

    # Install Diagnostic Tools
    environment.systemPackages = with pkgs; [
      inetutils
      mtr
      sysstat
    ];

  };

}
