{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.purescript;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.purescript.enable = lib.mkOptBool true;
      config.home.packages = lib.mkIf enable [
        pkgs.purescript
        pkgs.spago
      ];
    };
}
