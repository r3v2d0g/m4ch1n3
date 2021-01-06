{
  machine = { ... }: {};

  users = { lib, ucfg, ... }:
    let
      cfg = ucfg.shell.git;
      enable = ucfg.shell.enable && cfg.enable;
    in {
      options.m4ch1n3.shell.git.enable = lib.mkOptBool true;

      config.programs.git = lib.mkIf enable { enable = true; };
    };
}
