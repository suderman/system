{ config, lib, pkgs, this, ... }: let 
  inherit (this.lib) ls;
in {

  # Import all *.nix files in this directory
  imports = ls ./.;

  xdg.userDirs = with config.home; {
    enable = true;
    createDirectories = false;
    desktop = "${homeDirectory}/Action";
    download = "${homeDirectory}/Downloads";
    documents = "${homeDirectory}/Documents";
    music = "${homeDirectory}/Music";
    pictures = "${homeDirectory}/Pictures";
    videos = "${homeDirectory}/Videos";
    # publicShare = "${homeDirectory}/public";
  };

  services.keyd.enable = true;

}
