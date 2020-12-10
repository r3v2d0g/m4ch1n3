{
  machine = { ... }: {};

  users = { lib, ucfg, ... }:
    let
      cfg = ucfg.shell.git;
      enable = ucfg.shell.enable;
    in {
      options.m4ch1n3.shell.git = lib.optionalAttrs enable { enable = lib.mkOptBool true; };

      config.programs.git = lib.mkIf (enable && cfg.enable) { enable = true; };
    };
}
