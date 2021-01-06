{
  machine = { ... }: {};

  users = { lib, pkgs, ucfg, ... }:
    let
      cfg = ucfg.security.pass;
    in {
      options.m4ch1n3.security.pass.enable = lib.mkOptBool false;
      config.programs.password-store.enable = cfg.enable;
    };
}
