{
  machine = { ... }: {};

  users = { lib, mcfg, pkgs, ucfg, ... }:
    let
      cfg = ucfg.dev.rust;
      enable = mcfg.dev.enable && ucfg.dev.enable;
    in {
      options.m4ch1n3.dev.rust = lib.optionalAttrs enable { enable = lib.mkOptBool true; };

      config.home.packages = lib.mkIf (enable && cfg.enable) [
        pkgs.rustup
        pkgs.wasm-pack
      ];
    };
}
