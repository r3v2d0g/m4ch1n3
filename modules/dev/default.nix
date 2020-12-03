{
  machine = { lib, ... }: { options.m4ch1n3.dev.enable = lib.mkOptBool false; };

  users = { lib, mcfg, ... }:
    let
      enable = mcfg.dev.enable;
    in { options.m4ch1n3.dev = lib.optionalAttrs enable { enable = lib.mkOptBool true; }; };
}
