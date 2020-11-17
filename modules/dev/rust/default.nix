{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.rust;

    in { options.m4ch1n3.dev.rust =
           { enable = lib.mkDisableOption "rust"; };

         config.home.packages = lib.mkIf cfg.enable
           [ pkgs.rustup ];
       };
}
