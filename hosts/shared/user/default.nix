{ config, lib, pkgs, ... }: {

  # ---------------------------------------------------------------------------
  # Common configuration for all Home Manager hosts
  # ---------------------------------------------------------------------------
  imports = [ 
    
    # User modules
    ../../../modules/user 

    # Secrets and keys
    ../../../secrets 

    # Shared configuration
    ./nix.nix 
    ./packages.nix 
    ./user.nix 

  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";

}