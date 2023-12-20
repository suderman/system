{ pkgs, lib, ... }: let

  inherit (builtins) attrNames stringLength;
  inherit (lib) forEach mkOption types removePrefix removeSuffix;

  # Use systemd tmpfiles rules to create files, directories, symlinks and permissions changes
  # https://www.freedesktop.org/software/systemd/man/latest/tmpfiles.d.html
  rules = {

    # file "/etc/foobar" { mode = "0775"; user = "me"; group = "users"; text = "Hello world!"; };
    # f+ /etc/foobar 0775 me users - Hello world!
    # file "/etc/foo-resolv" { mode = "0775"; user = "me"; group = "users"; source = "/etc/resolv.conf"; };
    # C+ /etc/foo-resolv - - - - /etc/resolv.conf
    # z  /etc/foo-resolv 0775 me users - -
    file = path: { mode ? "0775", user ? "root", group ? "root", source ? "-", text ? "-", ... }: 
      trim ( if source != "-" then ''
        C+ ${path} - - - - ${source}
        z  ${path} ${mode} ${user} ${group} - -
      '' else ''
        f+ ${path} ${mode} ${user} ${group} - ${text}
      '' );

    # dir "/etc/foo-dir" { mode = "0775"; user = "me"; group = "users"; };
    # d /etc/foobaz 0755 me users - -
    # dir "/etc/foo-dir" { mode = "0775"; user = "me"; group = "users"; source = "/etc/default };
    # C+ /etc/foo-default - - - - /etc/default
    # Z  /etc/foo-default 0775 me users - -
    dir = path: { mode ? "0775", user ? "root", group ? "root", source ? "-", ... }:
      trim ( if source != "-" then ''
        C+ ${path} - - - - ${source}
        Z  ${path} ${mode} ${user} ${group} - -
      '' else ''
        d ${path} ${mode} ${user} ${group} - -
      '' );

    # mode "/etc/foobar" { mode = "0775"; user = "me"; group = "users; };
    # Z /etc/foobar 0755 me users -
    mode = path: { mode ? "-", user ? "-", group ? "-", ... }: 
      trim ''
        Z ${path} ${mode} ${user} ${group} - -
      '';

    # link "/etc/foobarlink" { source = "/etc/foobar"; };
    # L+ /etc/foobar - - - - /etc/foobarlink
    link = path: { source ? "/dev/null", ... }: 
      trim ''
        L+ ${path} - - - - ${source}
      '';

  };

  # Convert 3-digit mode (ie: 775) to 4-digit mode (ie: 0775) by padding a zero
  toMode = mode: let mode' = toString mode; in 
    if stringLength mode' == 3 then "0${mode'}" else mode'; 

  # Trim newlines from beginning and end of string
  trim = text: removePrefix "\n" ( removeSuffix "\n" text );

in {

  inherit (rules) file dir mode link;

  # Convert attr set into list of rules
  mkRules = file: forEach (attrNames file) ( path: 

    # Default rule type is "file"
    let attrs = file."${path}";
        type = ( if attrs ? type then attrs.type else "file" );

    # Build specified rule type
    in rules."${type}" path ( {}
      // ( if attrs ? mode then { mode = toMode attrs.mode; } else {} )
      // ( if attrs ? user then { user = toString attrs.user; } else {} )
      // ( if attrs ? group then { group = toString attrs.group; } else {} )
      // ( if attrs ? source then { source = toString attrs.source; } else {} )
      // ( if attrs ? text then { text = toString attrs.text; } else {} )
    )

  );

}
