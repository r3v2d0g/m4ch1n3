{
  machine = { inputs, lib, mcfg, ... }:
    let
      cfg = mcfg.editor.emacs;
    in {
      options.m4ch1n3.editor.emacs.enable = lib.mkOptBool true;
      config.nixpkgs.overlays = lib.mkIf cfg.enable [ inputs.emacs-overlay.overlay ];
    };

  users = { inputs, lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.editor.emacs;
      enable = mcfg.editor.emacs.enable;

      doom-d = pkgs.runCommand "doom.d" {
        inherit (cfg) configel customel funcsel initel packagesel;

        preferLocalBuild = true;
        allowSubstitutes = false;
      } ''
        mkdir -p $out

        echo "$configel" > $out/config.el
        echo "$customel" > $out/custom.el
        echo "$funcsel" > $out/funcs.el
        echo "$initel" > $out/init.el
        echo "$packagesel" > $out/packages.el
      '';

      doom-emacs = { pkgs, ... }@args: lib.recursiveUpdate
        (inputs.nix-doom-emacs.hmModule args)
        {
          options.programs.doom-emacs.doomPrivateDir.apply = lib.id;
        };
    in {
      options.m4ch1n3.editor.emacs = lib.optionalAttrs enable {
        enable = lib.mkOptBool true;

        initel = lib.mkOption { internal = true; };

        configel = lib.mkOptStr (builtins.readFile ./config.el);
        customel = lib.mkOptStr (builtins.readFile ./custom.el);
        funcsel = lib.mkOptStr (builtins.readFile ./funcs.el);
        packagesel = lib.mkOptStr (builtins.readFile ./packages.el);

        user.name = lib.mkOptStr null;
        user.email = lib.mkOptStr null;
      };

      imports = lib.optional enable doom-emacs;

      config = lib.mkIf (enable && cfg.enable) {
        home.packages = [
          pkgs.fd
          pkgs.ripgrep
        ];

        programs.doom-emacs = {
          enable = true;

          doomPrivateDir = doom-d;
          emacsPackage = pkgs.emacsGcc;

          emacsPackagesOverlay = self: super: {
            ion-mode = self.melpaBuild {
              pname = "ion-mode";
              version = "1.0.0";

              src = inputs.ion-mode;
              recipe = builtins.toFile "recipe" ''
                (ion-mode
                 :fetcher github
                 :repo "iwahbe/ion-mode")
              '';
            };
          };
        };
      };
    };
}
