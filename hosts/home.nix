# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, host, lib, config, pkgs, ... }: 

let 
  inherit (host) hostname username system;

in {

  imports = [
    ./${hostname}/home.nix
    # ./shared/vim.nix
  ];

  home.username = username;
  home.homeDirectory = (import ./shared/homedir.nix) { inherit host lib; }; 

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    bat 
    lf 
    fzf 
    wget
    git
    zsh
    fish
    nano
    micro
    cached-nix-shell
    nerdfonts
    joypixels
    # nnn 
    # owncloud-client
    # _1password-gui
    # nur.repos.mic92.hello-nur
    # neovim
  ];

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  # Enable home-manager and git
  programs.home-manager.enable = true;
  # programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
