# base.enable = true;
{ config, lib, pkgs, user, ... }: with lib; {

  # ---------------------------------------------------------------------------
  # User Configuration
  # ---------------------------------------------------------------------------
  config = mkIf config.base.enable {

    home.username = user;
    home.homeDirectory = "/${if (pkgs.stdenv.isLinux) then "home" else "Users"}/${user}";

    # Add support for ~/.local/bin
    home.sessionPath = [ "$HOME/.local/bin" ];

    # Aliases 
    home.shellAliases = with pkgs; rec {
      cp = "cp -i";
      rm = "rm -I";
      df = "df -h";
      diff = "diff --color=auto";
      du = "du -ch --summarize";
      fst = "sed -n '1p'";
      snd = "sed -n '2p'";
      ls = "LC_ALL=C ${coreutils}/bin/ls --color=auto --group-directories-first";
      la = "${ls} -A";
      l = "${ls} -Alho";
      map = "xargs -n1";
      maplines = "xargs -n1 -0";
      dmesg = "dmesg -H";
      rg = "rg --glob '!package-lock.json' --glob '!.git/*' --glob '!yarn.lock' --glob '!.yarn/*' --smart-case --hidden";
      grep = rg;
      tg = "tree-grepper";
      tree = "tree -a --dirsfirst -I .git";
      tl = "tldr";
      less = "less -R";
      type-clipboard = ''
        sh -c 'sudo sleep 5.0; sudo ydotool type -- "$(wl-paste)"'
      '';
    };

  };

}