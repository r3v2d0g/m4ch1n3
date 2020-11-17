{ config, lib, pkgs, ... }:

let flags = config.m4ch1n3.editor.emacs.init.lang.haskell.flags;

in { flags =
       [ "dante"
         "ghcide"
         "lsp"
       ];

     packages = [ pkgs.haskellPackages.hoogle ]
                ++ lib.optionals flags.dante
                  [ pkgs.ghc
                    pkgs.haskellPackages.cabal
                    pkgs.haskellPackages.ghc-mod
                  ]
                ++ lib.optional flags.ghcide pkgs.haskellPackages.ghcide
                ++ lib.optional flags.lsp pkgs.haskellPackages.haskell-language-server;
   }
