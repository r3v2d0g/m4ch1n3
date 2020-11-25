{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.security.ssh;

    in { options.m4ch1n3.security.ssh =
           { enable = lib.mkEnableOption "openssh";

             address = lib.mkStrOption {};
           };

         config.services.openssh = lib.mkIf cfg.enable
           { enable = true;
             permitRootLogin = "no";

             listenAddresses = [{ addr = cfg.address; port = 22; }];
           };
       };

  users = { ... }: {};
}
