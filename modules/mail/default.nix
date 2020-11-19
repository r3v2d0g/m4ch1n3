{ machine = { ... }: {};

  users = { config, lib, ... }:
    let cfg = config.m4ch1n3.mail;

    in { options.m4ch1n3.mail =
           { enable = lib.mkEnableOption "mail"; };
       };
}
