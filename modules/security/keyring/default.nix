{
  machine = { lib, mcfg, ... }:
    let cfg = mcfg.security.keyring;
    in {
      options.m4ch1n3.security.keyring.enable = lib.mkOptBool true;

      config.services.gnome.gnome-keyring.enable = cfg.enable;
    };

  users = { ... }: {};
}
