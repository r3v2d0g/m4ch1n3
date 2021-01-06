{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, ... }: {
    options.m4ch1n3.theme.wm.onepassword = {
      theme = lib.mkOptEnumNull [ "system" "dark" "light" ] "dark";
    };
  };
}
