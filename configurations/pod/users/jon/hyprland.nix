{ config, lib, pkgs, this, ... }: {

  config.wayland.windowManager.hyprland = {
    settings = {};
    extraSinks = [ "bluez_output.AC_3E_B1_9F_43_35.1" ]; # pixel buds pro
    hiddenSinks = [];
  };

}
