{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.python;

    in { options.m4ch1n3.dev.python =
           { enable = lib.mkDisableOption "python";

             package = lib.mkPackageOption
               { default = pkgs.python38; };

             packages = lib.mkOption
               { default = pkgs.python38Packages; };
           };

         config.home.packages = lib.mkIf cfg.enable
           [ cfg.package ];
       };
}
