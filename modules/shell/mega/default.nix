{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.shell.mega;
      enable = ucfg.shell.enable && cfg.enable;
    in {
      options.m4ch1n3.shell.mega.enable = lib.mkOptBool false;

      config.home.packages = lib.optional enable pkgs.megacmd;
    };
}
