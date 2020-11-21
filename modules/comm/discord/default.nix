{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.comm.discord;
        enable = config.m4ch1n3.comm.enable;

    in { options.m4ch1n3.comm.discord = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "discord"; };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages = [ pkgs.discord ]; };
       };
}
