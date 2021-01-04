{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, pkgs, ... }@args:
    let
      cfg = ucfg.editor.emacs;

      packages = {
        atomic-chrome = import ./atomic-chrome args;
        evil-snipe = import ./evil-snipe args;
        ion-mode = import ./ion-mode args;
        ox-gfm = import ./ox-gfm args;
      };

      packagesel = ''
        ;; -*- no-byte-compile: t; -*-

        ${lib.concatStringsNl (lib.mapAttrsValues package cfg.packages)}
        ${lib.concatStringsNl (lib.mapAttrsValues package cfg.extraPackages)}

        ${lib.concatMapStringsNl (pkg: "(unpin! ${pkg})") cfg.unpinPackages}
      '';

      package = pkg: { enable, recipe, ... }:
        "(package! ${pkg}"
        + (lib.optionalString (! enable) " :disable t")
        + (lib.optionalString (enable && recipe != "") " :recipe ${recipe}")
        + ")";
    in {
      options.m4ch1n3.editor.emacs = {
        packages = lib.mapAttrs (_: { default, packages, recipe }: {
          enable = lib.mkOptBool default;
          packages = lib.mkOptInternal packages;
          recipe = lib.mkOptInternal recipe;
        }) packages;

        extraPackages = lib.mkOptSubmodAttrs {
          enable = lib.mkOptBool true;
          packages = lib.mkOptPkgList [];
          recipe = lib.mkOptStrNull null;
        } {};

        unpinPackages = lib.mkOptStrList [];
      };

      config = lib.mkIf cfg.enable {
        m4ch1n3.editor.emacs.packagesel = packagesel;

        home.packages = lib.flatten (lib.mapFilterAttrsValues
          (_: { packages, ... }: packages)
          (_: { enable, ... }: enable)
          cfg.packages
        ) ++ lib.flatten (lib.mapFilterAttrsValues
          (_: { packages, ... }: packages)
          (_: { enable, ... }: enable)
          cfg.extraPackages
        );
      };
    };
}
