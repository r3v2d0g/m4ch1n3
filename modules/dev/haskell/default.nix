{ machine = { ... }: {};

  users = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.dev.haskell;

    in { options.m4ch1n3.dev.haskell =
           { enable = lib.mkDisableOption "haskell"; };

         config.home.packages = lib.mkIf cfg.enable
           [ pkgs.cabal-install
             pkgs.ghc
             pkgs.haskellPackages.hpack
             pkgs.stack
           ];
       };
}
