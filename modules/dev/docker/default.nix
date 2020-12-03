{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.dev.docker;
      enable = mcfg.dev.enable;
    in {
      options.m4ch1n3.dev.docker = lib.optionalAttrs enable { enable = lib.mkOptBool true; };
      config.virtualisation.docker = lib.mkIf (enable && cfg.enable) {
        enable = true;
        enableOnBoot = true;
      };
    };

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.docker;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && mcfg.dev.docker.enable;
    in {
      options.m4ch1n3.dev.docker = lib.optionalAttrs enable { enable = lib.mkOptBool false; };
      config.home.packages = lib.mkIf (enable && cfg.enable) [
        pkgs.docker-compose
        pkgs.docker-machine
      ];
    };
}
