{ machine = { ... }: {};

  users = { lib, mcfg, ucfg, ... }:
    let
      cfg = ucfg.wm.term;
      enable = mcfg.wm.enable && ucfg.wm.enable;
    in {
      options.m4ch1n3.wm.term = lib.optionalAttrs enable { enable = lib.mkOptBool true; };

      config.programs.kitty = lib.mkIf (enable && cfg.enable) {
        enable = true;

        keybindings = {
          "ctrl+tab"       = "next_tab";
          "ctrl+shift+tab" = "next_tab";
          "ctrl+shift+t"   = "new_tab";
          "ctrl+shift+w"   = "close_tab";
        };

        settings = {
          enable_audio_bell = false;
          update_check_interval = 0;

          tab_bar_edge  = "bottom";
          tab_bar_style = "separator";
          tab_separator = "\"  |  \"";

          open_url_with = "chromium";
        };
      };
    };
}
