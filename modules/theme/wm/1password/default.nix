{ machine = { ... }: {};

  users = { config, lib, mconfig, ... }:
    let cfg = config.m4ch1n3.theme.wm.onepassword;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.onepassword.enable;

    in { options.m4ch1n3.theme.wm.onepassword = lib.optionalAttrs enable
           { theme = lib.mkNullOrEnumOption [ "system" "dark" "light" ]
               { default = "dark"; };
           };
       };
}
