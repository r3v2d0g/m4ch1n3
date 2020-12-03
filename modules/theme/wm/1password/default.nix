{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, ... }:
    let
      cfg = ucfg.theme.wm.onepassword;
      enable = mcfg.wm.enable && ucfg.wm.enable
               && ucfg.wm.onepassword.enable;
    in {
      options.m4ch1n3.theme.wm.onepassword = lib.optionalAttrs enable {
        theme = lib.mkOptEnumNull [ "system" "dark" "light" ] "dark";
      };
    };
}
