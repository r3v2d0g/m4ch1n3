{ machine = { ... }: {};

  users = { config, lib, mconfig, ... }:
    let cfg = config.m4ch1n3.theme.wm.term;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.term.enable;
        colors = mconfig.m4ch1n3.theme.colors;
        fonts = mconfig.m4ch1n3.theme.fonts;

    in { options.m4ch1n3.theme.wm.term = lib.optionalAttrs enable
           { colors =
               { fg = lib.mkColorOption
                   { default = "fg"; };

                 bg = lib.mkColorOption
                   { default = "bg"; };

                 tab-bar.bg = lib.mkColorOption
                   { default = "bg"; };

                 tab-bar.active.fg = lib.mkColorOption
                   { default = "base0"; };

                 tab-bar.active.bg = lib.mkColorOption
                   { default = "base0"; };

                 tab-bar.inactive.fg = lib.mkColorOption
                   { default = "base0"; };

                 tab-bar.inactive.bg = lib.mkColorOption
                   { default = "base0"; };

                 console =
                   { color0 = lib.mkColorOption
                       { default = "base0"; };

                     color1 = lib.mkColorOption
                       { default = "red"; };

                     color2 = lib.mkColorOption
                       { default = "green"; };

                     color3 = lib.mkColorOption
                       { default = "yellow"; };

                     color4 = lib.mkColorOption
                       { default = "blue"; };

                     color5 = lib.mkColorOption
                       { default = "magenta"; };

                     color6 = lib.mkColorOption
                       { default = "cyan"; };

                     color7 = lib.mkColorOption
                       { default = "base8"; };

                     color8 = lib.mkColorOption
                       { default = "base1"; };

                     color9 = lib.mkColorOption
                       { default = "red"; };

                     color10 = lib.mkColorOption
                       { default = "teal"; };

                     color11 = lib.mkColorOption
                       { default = "yellow"; };

                     color12 = lib.mkColorOption
                       { default = "blue"; };

                     color13 = lib.mkColorOption
                       { default = "violet"; };

                     color14 = lib.mkColorOption
                       { default = "cyan"; };

                     color15 = lib.mkColorOption
                       { default = "fg"; };
                   };
               };
           };

         config = lib.mkIf enable
           { programs.kitty =
               { font = fonts.code;

                 settings =
                   { font_size = "11.0";

                     foreground = colors.${cfg.colors.fg};
                     background = colors.${cfg.colors.bg};

                     tab_bar_background = colors.${cfg.colors.tab-bar.bg};

                     active_tab_foreground = colors.${cfg.colors.tab-bar.active.fg};
                     active_tab_background = colors.${cfg.colors.tab-bar.active.bg};
                     active_tab_font_style = "bold";

                     inactive_tab_foreground = colors.${cfg.colors.tab-bar.inactive.fg};
                     inactive_tab_background = colors.${cfg.colors.tab-bar.inactive.bg};
                   } // lib.mapAttrs (_: color: colors.${color}) cfg.colors.console;
               };
           };
       };
}
