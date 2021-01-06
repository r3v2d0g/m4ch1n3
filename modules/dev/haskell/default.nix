{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.haskell;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.haskell.enable = lib.mkOptBool false;
      config.home.packages = lib.mkIf enable [
        pkgs.cabal-install
        pkgs.ghc
        pkgs.haskellPackages.hpack
        pkgs.stack
      ];
    };
}
