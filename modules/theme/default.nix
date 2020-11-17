{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.theme;

        defaultColors =
          { bg = "#0c0a20";
            bg_alt = "#090819";
            base0 = "#131033";
            base1 = "#161130";
            base2 = "#110d26";
            base3 = "#3b4167";
            base4 = "#2d2844";
            base5 = "#ba45a3";
            base6 = "#6a6ea3";
            base7 = "#6564d1";
            base8 = "#919ad9";
            fg_alt = "#7984d1";
            fg = "#f2f3f7";

            grey = "#546a90";
            red = "#e61f44";
            orange = "#ff9b50";
            green = "#a7da1e";
            teal = "#a875ff";
            yellow = "#ffd400";
            blue = "#1ea8fc";
            dark_blue = "#3f88ad";
            magenta = "#ff2afc";
            violet = "#df85ff";
            cyan = "#42c6ff";
            dark_cyan = "#204052";
          };

    in { options.m4ch1n3.theme =
           { colors = lib.genAttrs
               lib.colorNames
               (color: lib.mkStrOption
                 { default = defaultColors.${color}; }
               );
           };
       };

  users = { ... }: {};
}
