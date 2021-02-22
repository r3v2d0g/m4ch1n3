{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.rust;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;

      rust-nightly = (pkgs.rustChannelOf {
        channel = "nightly";
        date = "2021-02-17";
        sha256 = "1lfb9w6hkfff8mi238izqnawbm8jg2kimcwkg1px714hp39xwryq";
      }).rust.override {
        extensions = ["rust-src"];
      };
    in {
      options.m4ch1n3.dev.rust.enable = lib.mkOptBool true;

      config.home = lib.mkIf enable {
        packages = [
          rust-nightly
          pkgs.wasm-pack
        ];

        sessionVariables."RUST_SRC_PATH" = "${rust-nightly}/lib/rustlib/src/rust/library";
      };
    };
}
