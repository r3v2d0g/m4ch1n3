{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.lisp;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.lisp.enable = lib.mkOptBool false;
      config.home.packages = lib.mkIf enable [
        pkgs.sbcl
        pkgs.lispPackages.quicklisp
      ];
    };
}
