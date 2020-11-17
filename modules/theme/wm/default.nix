{ machine = { ... }: {};

  users = { config, lib, mconfig,... }:
    let cfg = config.m4ch1n3.theme.wm;
        enable = mconfig.m4ch1n3.wm.enable
                 && config.m4ch1n3.wm.enable;
        colors = mconfig.m4ch1n3.theme.colors;
        fonts = mconfig.m4ch1n3.theme.fonts;

    in { options.m4ch1n3.theme.wm = lib.optionalAttrs enable
           { colors =
               { background = lib.mkColorOption
                   { default = "bg"; };

                 focused.fg = lib.mkColorOption
                   { default = "fg"; };

                 focused.bg = lib.mkColorOption
                   { default = "bg"; };

                 focused.border = lib.mkColorOption
                   { default = "blue"; };

                 focusedInactive.fg = lib.mkColorOption
                   { default = "fg"; };

                 focusedInactive.bg = lib.mkColorOption
                   { default = "bg"; };

                 focusedInactive.border = lib.mkColorOption
                   { default = "bg"; };

                 unfocused.fg = lib.mkColorOption
                   { default = "fg_alt"; };

                 unfocused.bg = lib.mkColorOption
                   { default = "bg_alt"; };

                 unfocused.border = lib.mkColorOption
                   { default = "bg_alt"; };

                 urgent.fg = lib.mkColorOption
                   { default = "fg_alt"; };

                 urgent.bg = lib.mkColorOption
                   { default = "bg_alt"; };

                 urgent.border = lib.mkColorOption
                   { default = "bg_alt"; };
               };
           };

         config = lib.mkIf enable
           { wayland.windowManager.sway.config =
               { fonts = [ "${fonts.default.name} 10" ];

                 colors = lib.mapFilterAttrs
                   (_: c:
                     { border = colors.${c.bg};
                       background = colors.${c.bg};
                       text = colors.${c.fg};
                       indicator = colors.${c.bg};
                       childBorder = colors.${c.border};
                     }
                   ) (c: _: c != "background") cfg.colors;

                 output."*" = lib.optionalAttrs (! isNull cfg.colors.background)
                   { bg = "${colors.${cfg.colors.background}} solid_color"; };
               };
           };
       };
}
