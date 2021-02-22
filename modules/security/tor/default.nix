{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.security.tor;
      enable = mcfg.wm.enable && mcfg.wm.browser.enable
               && ucfg.wm.enable && ucfg.wm.browser.enable
               && cfg.enable;
    in {
      options.m4ch1n3.security.tor.enable = lib.mkOptBool true;

      config.home.packages = lib.mkIf enable [ pkgs.torbrowser ];
    };
}
