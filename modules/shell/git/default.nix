{ machine = { ... }: {};

  users = { config, lib, ... }:
    let cfg = config.m4ch1n3.shell.git;

    in { options.m4ch1n3.shell.git =
           { enable = lib.mkDisableOption "git"; };

         config.programs.git.enable = cfg.enable;
       };
}
