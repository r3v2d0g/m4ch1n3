{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.rust;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.rust.enable = lib.mkOptBool true;

      config.home = lib.mkIf enable {
        packages = [
          pkgs.rust-nightly
          pkgs.wasm-pack
        ];

        sessionVariables."RUST_SRC_PATH" = "${pkgs.rust-nightly}/lib/rustlib/src/rust/library";
      };
    };
}
