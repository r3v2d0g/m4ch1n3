{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.nodejs;

    in { options.m4ch1n3.dev.nodejs =
           { enable = lib.mkDisableOption "nodejs"; };

         config.home.packages = lib.mkIf cfg.enable
           [ pkgs.nodejs
             pkgs.nodePackages.npm
             pkgs.yarn
           ];
       };
}
