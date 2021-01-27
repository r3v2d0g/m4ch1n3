{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.rust;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;

      rust-nightly = (pkgs.rustChannelOf {
        channel = "nightly";
        date = "2021-01-20";
        sha256 = "0a9a29grqy2vvy4ygixgy0spm8r8pvavh359fllgqsvacm55pi81";
      }).rust.override {
        extensions = ["rust-src"];
      };
    in {
      options.m4ch1n3.dev.rust.enable = lib.mkOptBool true;

      config.home.packages = lib.mkIf enable [
        rust-nightly
        pkgs.wasm-pack
      ];
    };
}
