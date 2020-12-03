{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.haskell;
      enable = mcfg.dev.enable && ucfg.dev.enable;
    in {
      options.m4ch1n3.dev.haskell = lib.optionalAttrs enable { enable = lib.mkOptBool false; };
      config.home.packages = lib.mkIf (enable && cfg.enable) [
        pkgs.cabal-install
        pkgs.ghc
        pkgs.haskellPackages.hpack
        pkgs.stack
      ];
    };
}
