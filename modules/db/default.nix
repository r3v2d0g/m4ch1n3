{
  machine = { lib, ... }: {
    options.m4ch1n3.db = { enable = lib.mkOptBool false; };
  };

  users = { ... }: {};
}
