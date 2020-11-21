{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.comm.pm;
        enable = config.m4ch1n3.comm.enable;

    in { options.m4ch1n3.comm.pm = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "protonmail-bridge"; };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages = [ pkgs.protonmail-bridge ]; };
       };
}
