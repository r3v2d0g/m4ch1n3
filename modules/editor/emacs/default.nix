{ machine = { ... }: {};

  users = { config, inputs, lib, pkgs, ... }@args:
    let cfg = config.m4ch1n3.editor.emacs;

        doom-d = pkgs.runCommand "doom.d"
          { configEl = cfg.config-el;
            customEl = cfg.custom-el;
            funcsEl = cfg.funcs-el;
            initEl = cfg.init-el;
            packagesEl = cfg.packages-el;

            preferLocalBuild = true;
            allowSubstitutes = false;
          } ''
               mkdir -p $out

               echo "$configEl" > $out/config.el
               echo "$customEl" > $out/custom.el
               echo "$funcsEl" > $out/funcs.el
               echo "$initEl" > $out/init.el
               echo "$packagesEl" > $out/packages.el
            '';


    in { options.m4ch1n3.editor.emacs =
           { enable = lib.mkDisableOption "emacs";

             init-el = lib.mkInternalOption {};

             config-el = lib.mkStrOption
               { default = builtins.readFile ../doom.d/config.el; };

             custom-el = lib.mkStrOption
               { default = builtins.readFile ../doom.d/custom.el; };

             funcs-el = lib.mkStrOption
               { default = builtins.readFile ../doom.d/funcs.el; };

             packages-el = lib.mkStrOption
               { default = builtins.readFile ../doom.d/packages.el; };

             user.name = lib.mkStrOption {};
             user.email = lib.mkStrOption {};
           };

         config = lib.mkIf cfg.enable
           { home.packages =
               [ pkgs.fd
                 pkgs.ripgrep
               ];

             programs.doom-emacs =
               { enable = true;

                 doomPrivateDir = doom-d;
                 emacsPackage = pkgs.emacsGcc;

                 emacsPackagesOverlay = self: super:
                   { ion-mode = self.melpaBuild
                       { pname = "ion-mode";
                         version = "1.0.0";

                         src = inputs.ion-mode;
                         recipe = builtins.toFile "recipe"
                           ''
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
