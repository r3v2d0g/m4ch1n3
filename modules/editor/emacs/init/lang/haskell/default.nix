{ lib, mcfg, pkgs, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && ucfg.dev.haskell.enable;
  flags = ucfg.editor.emacs.modules.lang.haskell.flags;
in {
  inherit default;

  flags.dante = false;
  flags.ghcide = false;
  flags.lsp = true;

  packages = [ pkgs.haskellPackages.hoogle ]
             ++ lib.optionals flags.dante [
               pkgs.ghc
               pkgs.haskellPackages.cabal
               pkgs.haskellPackages.ghc-mod
             ]
             ++ lib.optional flags.ghcide pkgs.haskellPackages.ghcide
             ++ lib.optional flags.lsp pkgs.haskellPackages.haskell-language-server;
}
