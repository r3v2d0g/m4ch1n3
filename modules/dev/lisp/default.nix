{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.lisp;
      enable = mcfg.dev.enable && ucfg.dev.enable;
    in {
      options.m4ch1n3.dev.lisp = lib.optionalAttrs enable { enable = lib.mkOptBool false; };
      config.home.packages = lib.mkIf (enable && cfg.enable) [
        pkgs.sbcl
        pkgs.lispPackages.quicklisp
      ];
    };
}
