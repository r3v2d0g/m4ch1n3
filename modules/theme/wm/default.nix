{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, ... }:
    let
      cfg = ucfg.theme.wm;
      enable = mcfg.wm.enable && ucfg.wm.enable;
      colors = mcfg.theme.colors;
      fonts = mcfg.theme.fonts;
    in {
      options.m4ch1n3.theme.wm = {
        colors = {
          background = lib.mkOptColor "bg";

          focused.fg = lib.mkOptColor "fg";
          focused.bg = lib.mkOptColor "bg";
          focused.border = lib.mkOptColor "blue";

          focusedInactive.fg = lib.mkOptColor "fg";
          focusedInactive.bg = lib.mkOptColor "bg";
          focusedInactive.border = lib.mkOptColor "bg";

          unfocused.fg = lib.mkOptColor "fg_alt";
          unfocused.bg = lib.mkOptColor "bg_alt";
          unfocused.border = lib.mkOptColor "bg_alt";

          urgent.fg = lib.mkOptColor "fg_alt";
          urgent.bg = lib.mkOptColor "bg_alt";
          urgent.border = lib.mkOptColor "bg_alt";
        };
      };

      config.wayland.windowManager.sway.config = lib.mkIf enable {
        fonts = [ "${fonts.default.name} 10" ];

        colors = lib.mapFilterAttrs (_: c: {
          border = colors.${c.bg};
          background = colors.${c.bg};
          text = colors.${c.fg};
          indicator = colors.${c.bg};
          childBorder = colors.${c.border};
        }) (c: _: c != "background") cfg.colors;

        output."*".bg = lib.mkIf (! isNull cfg.colors.background)
          "${colors.${cfg.colors.background}} solid_color";
      };
    };
}
