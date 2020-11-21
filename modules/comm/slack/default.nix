{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.comm.slack;
        enable = config.m4ch1n3.comm.enable;

    in { options.m4ch1n3.comm.slack = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "slack"; };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages = [ pkgs.slack ]; };
       };
}
