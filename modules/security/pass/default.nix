{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.security.pass;

    in { options.m4ch1n3.security.pass =
           { enable = lib.mkEnableOption "password-store"; };

         config.programs.password-store = lib.mkIf cfg.enable
           { enable = true; };
       };
}
