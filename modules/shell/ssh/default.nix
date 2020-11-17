{ machine = { ... }: {};

  users = { config, lib, ... }:
    let cfg = config.m4ch1n3.shell.ssh;

    in { options.m4ch1n3.shell.ssh =
           { enable = lib.mkDisableOption "ssh"; };

         config.programs.ssh = lib.mkIf cfg.enable
           { enable = true;

             matchBlocks =
               { "github.com" =
                   { user = "git";
                     hostname = "github.com";
                   };
               };
           };
       };
}
