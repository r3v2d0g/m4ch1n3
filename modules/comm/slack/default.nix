{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.comm.slack;
      enable = ucfg.comm.enable && cfg.enable;
    in {
      options.m4ch1n3.comm.slack.enable = lib.mkOptBool true;
      config.home.packages = lib.mkIf enable [ pkgs.slack ];
    };
}
