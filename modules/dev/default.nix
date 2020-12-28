{
  machine = { lib, ... }: { options.m4ch1n3.dev.enable = lib.mkOptBool false; };

  users = { config, lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev;
      enable = mcfg.dev.enable;
    in {
      options.m4ch1n3.dev = lib.optionalAttrs enable { enable = lib.mkOptBool true; };

      config.home.packages = lib.mkIf (enable && cfg.enable) [ pkgs.binutils ];
    };
}
