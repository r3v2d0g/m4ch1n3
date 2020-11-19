{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.security.yubico;

    in { options.m4ch1n3.security.yubico =
           { enable = lib.mkEnableOption "yubico"; };

         config.security.pam.yubico = lib.mkIf cfg.enable
           {  enable = true;
              mode = "challenge-response";
           };
       };

  users = { ... }: {};
}
