{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.mail.pm;
        enable = config.m4ch1n3.mail.enable;

    in { options.m4ch1n3.mail.pm = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "enable"; };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages = [ pkgs.protonmail-bridge ]; };
       };
}
