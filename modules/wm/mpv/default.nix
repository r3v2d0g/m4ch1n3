{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.wm.mpv;
      enable = mcfg.wm.enable && ucfg.wm.enable
               && cfg.enable;
    in {
      options.m4ch1n3.wm.mpv.enable = lib.mkOptBool true;

      config.home.packages = lib.optional enable pkgs.mpv;
    };
}
