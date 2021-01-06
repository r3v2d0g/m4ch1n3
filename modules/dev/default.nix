{
  machine = { lib, ... }: { options.m4ch1n3.dev.enable = lib.mkOptBool false; };

  users = { config, lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev;
      enable = mcfg.dev.enable && cfg.enable;
    in {
      options.m4ch1n3.dev.enable = lib.mkOptBool true;

      config.home.packages = lib.optional enable pkgs.binutils;
    };
}
