{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.shell.p7zip;
      enable = ucfg.shell.enable && cfg.enable;
    in {
      options.m4ch1n3.shell.p7zip.enable = lib.mkOptBool true;

      config.home.packages = lib.mkIf enable [ pkgs.p7zip ];
    };
}
