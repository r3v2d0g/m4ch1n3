{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, ... }:
    let
      cfg = ucfg.theme.wm.term;
      enable = mcfg.wm.enable && ucfg.wm.enable
               && ucfg.wm.term.enable;
      colors = mcfg.theme.colors;
      fonts = mcfg.theme.fonts;
    in {
      options.m4ch1n3.theme.wm.term = {
        fontSize = lib.mkOptStr "11.0";

        colors = {
          fg = lib.mkOptColor "fg";
          bg = lib.mkOptColor "bg";


          tab-bar.bg = lib.mkOptColor "bg";
          tab-bar.active.fg = lib.mkOptColor "fg";
          tab-bar.active.bg = lib.mkOptColor "base0";
          tab-bar.inactive.fg = lib.mkOptColor "base8";
          tab-bar.inactive.bg = lib.mkOptColor "base0";

          console.color0 = lib.mkOptColor "base0";
          console.color1 = lib.mkOptColor "red";
          console.color2 = lib.mkOptColor "green";
          console.color3 = lib.mkOptColor "yellow";
          console.color4 = lib.mkOptColor "blue";
          console.color5 = lib.mkOptColor "magenta";
          console.color6 = lib.mkOptColor "cyan";
          console.color7 = lib.mkOptColor "base8";
          console.color8 = lib.mkOptColor "fg_alt";
          console.color9 = lib.mkOptColor "red";
          console.color10 = lib.mkOptColor "teal";
          console.color11 = lib.mkOptColor "yellow";
          console.color12 = lib.mkOptColor "blue";
          console.color13 = lib.mkOptColor "violet";
          console.color14 = lib.mkOptColor "cyan";
          console.color15 = lib.mkOptColor "fg";
        };
      };

      config.programs.kitty = lib.mkIf enable {
        font = fonts.code;

        settings = {
          font_size = cfg.fontSize;

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
}
