{
  machine = { ... }: {};

  users = { lib, ucfg, ... }:
    let
      cfg = ucfg.shell.git;
    in {
      options.m4ch1n3.shell.git.enable = lib.mkOptBool true;

      config.programs.git.enable = cfg.enable;
    };
}
