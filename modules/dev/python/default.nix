{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.python;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.python = {
        enable = lib.mkOptBool true;

        package = lib.mkOptPkg pkgs.python38;
        packages = lib.mkOptAny pkgs.python38Packages;
      };

      config.home.packages = lib.mkIf enable [
        cfg.package

        cfg.packages.fastecdsa
        cfg.packages.pip
        cfg.packages.python_magic
        cfg.packages.pygraphviz
        cfg.packages.secp256k1
        cfg.packages.setuptools
      ];
    };
}
