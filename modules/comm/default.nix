{
  machine = { ... }: {};

  users = { lib, ... }: { options.m4ch1n3.comm.enable = lib.mkOptBool false; };
}
