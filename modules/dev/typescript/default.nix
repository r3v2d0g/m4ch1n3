{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.typescript;

    in { options.m4ch1n3.dev.typescript =
           { enable = lib.mkDisableOption "typescript"; };

         config.home.packages = lib.mkIf cfg.enable
           [ pkgs.nodePackages.typescript ];
       };
}
