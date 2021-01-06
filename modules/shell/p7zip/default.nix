{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.shell.p7zip;
      enable = ucfg.shell.enable && cfg.enable;

      p7zipFull = pkgs.p7zip.override { enableUnfree = true; };
    in {
      options.m4ch1n3.shell.p7zip.enable = lib.mkOptBool true;

      config.home.packages = lib.optional enable p7zipFull;
    };
}
