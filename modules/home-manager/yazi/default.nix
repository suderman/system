# modules.yazi.enable = true;
{ config, lib, pkgs, ... }: 

with pkgs; 

let 
  cfg = config.modules.yazi;

in {

  # Taken from unstable, expected to be added in 23.11
  imports = [ ./yazi.nix ];

  options = {
    modules.yazi.enable = lib.options.mkEnableOption "yazi"; 
  };

  config = lib.mkIf cfg.enable {

    programs.yazi = {
      enable = true;
      package = pkgs.unstable.yazi;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

  };

}
