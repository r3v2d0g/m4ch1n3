{ machine = { ... }: {};

  users = { config, lib, ... }:
    let cfg = config.m4ch1n3.comm;

    in { options.m4ch1n3.comm =
           { enable = lib.mkEnableOption "communication"; };
       };
}
