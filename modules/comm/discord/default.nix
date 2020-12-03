{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.comm.discord;
      enable = ucfg.comm.enable;
    in {
      options.m4ch1n3.comm.discord = lib.optionalAttrs enable { enable = lib.mkOptBool true; };
      config.home.packages = lib.mkIf (enable && cfg.enable) [ pkgs.discord ];
    };
}
