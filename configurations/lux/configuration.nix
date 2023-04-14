{ config, pkgs, ... }: {

  imports = [ 
    ./hardware-configuration.nix
    ./additional-storage.nix
  ];

  # Btrfs mount options
  fileSystems."/".options = [ "compress=zstd" "space_cache=v2" "discard=async" "noatime" ];
  fileSystems."/nix".options = [ "compress=zstd" "space_cache=v2" "discard=async" "noatime" ];

  modules.base.enable = true;
  modules.secrets.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Snapshots & backup
  modules.btrbk.enable = true;

  # Memory management
  modules.earlyoom.enable = true;

  # Keyboard control
  modules.keyd.enable = true;
  modules.ydotool.enable = true;

  # Apps
  programs.mosh.enable = true;
  modules.neovim.enable = true;

  # Web services
  modules.tailscale.enable = true;
  modules.ddns.enable = true;
  modules.whoami.enable = true;
  modules.tautulli.enable = true;
  modules.jellyfin.enable = true;

  modules.plex.enable = true;

  modules.immich = {
    enable = true;
    dataDir = "/data/immich";
  };

  modules.sabnzbd.enable = true;
  # modules.radarr.enable = true;

  # /data/immich
  # /media/movies

  # # Snapshot photos subvolume stored on /data
  # services.btrbk.instances.local.settings = {
  #   volume."/mnt/ssd" = {
  #     snapshot_dir = "snapshots";
  #     target = "/mnt/raid/backups/lux";
  #     subvolume."data".snapshot_preserve = "48h 7d 4w";
  #   };
  # };
}
