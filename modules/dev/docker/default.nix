{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.dev.docker;

    in { options.m4ch1n3.dev.docker =
           { enable = lib.mkDisableOption "docker"; };

         config = lib.mkIf cfg.enable
           { virtualisation.docker =
               { enable = true;
                 enableOnBoot = true;
               };
           };
       };

  users = { config, lib, mconfig, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.docker;
        enable = mconfig.m4ch1n3.dev.docker.enable;

    in { options.m4ch1n3.dev.docker = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "docker"; };

         config = lib.mkIf (enable && cfg.enable)
           { home.packages = [ pkgs.docker-machine ]; };
       };
}
