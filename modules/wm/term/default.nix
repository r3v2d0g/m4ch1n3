{ machine = { ... }: {};

  users = { config, lib, mconfig, ... }:
    let cfg = config.m4ch1n3.wm.term;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable;

    in { options.m4ch1n3.wm.term = lib.optionalAttrs enable
           { enable = lib.mkDisableOption "terminal"; };

         config.programs.kitty = lib.mkIf (enable && cfg.enable)
           { enable = true;

             keybindings =
               { "ctrl+tab"       = "next_tab";
                 "ctrl+shift+tab" = "next_tab";
                 "ctrl+shift+t"   = "new_tab";
                 "ctrl+shift+w"   = "close_tab";
               };

             settings =
               { enable_audio_bell = false;
                 update_check_interval = 0;

                 tab_bar_edge  = "bottom";
                 tab_bar_style = "separator";
                 tab_separator = "\"  |  \"";

                 open_url_with = "chromium";
               };
           } ;
       };
}
