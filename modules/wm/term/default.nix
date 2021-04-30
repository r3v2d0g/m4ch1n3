{ machine = { ... }: {};

  users = { lib, mcfg, ucfg, ... }:
    let
      cfg = ucfg.wm.term;
      enable = mcfg.wm.enable && ucfg.wm.enable
               && cfg.enable;
    in {
      options.m4ch1n3.wm.term.enable = lib.mkOptBool true;

      config.programs.kitty = lib.mkIf enable {
        enable = true;

        keybindings = {
          "ctrl+tab"         = "next_tab";
          "ctrl+shift+tab"   = "prev_tab";

          "ctrl+t"           = "new_tab";
          "ctrl+w"           = "close_tab";

          "ctrl+enter"       = "new_window";
          "ctrl+shift+w"     = "close_window";

          "ctrl+shift+enter" = "detach_window";
          "ctrl+shift+t"     = "detach_window tab";

          "ctrl+h"           = "neighboring_window left";
          "ctrl+j"           = "neighboring_window down";
          "ctrl+k"           = "neighboring_window up";
          "ctrl+l"           = "neighboring_window right";

          "ctrl+shift+h"     = "move_window left";
          "ctrl+shift+j"     = "move_window down";
          "ctrl+shift+k"     = "move_window up";
          "ctrl+shift+l"     = "move_window right";

          "ctrl+alt+l"       = "next_layout";
          "ctrl+alt+h"       = "goto_layout horizontal";
          "ctrl+alt+j"       = "goto_layout vertical";
          "ctrl+alt+k"       = "goto_layout tall";
          "ctrl+alt+g"       = "goto_layout grid";
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
