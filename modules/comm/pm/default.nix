{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.comm.pm;
      enable = ucfg.comm.enable;
    in {
      options.m4ch1n3.comm.pm = lib.optionalAttrs enable { enable = lib.mkOptBool true; };
      config.home.packages = lib.mkIf (enable && cfg.enable) [ pkgs.protonmail-bridge ];
    };
}
