{
  machine = { lib, mcfg, pkgs, ... }:
    let
      cfg = mcfg.theme.console;
      colors = mcfg.theme.colors;
    in {
      options.m4ch1n3.theme.console = {
        colors = lib.mkOptColorList [
          "base0"
          "red"
          "green"
          "yellow"
          "blue"
          "magenta"
          "cyan"
          "base8"
          "base1"
          "red"
          "teal"
          "yellow"
          "blue"
          "violet"
          "cyan"
          "fg"
        ];

        font = lib.mkOptFont "Tamzen8x16" pkgs.tamzen;
      };

      config.console = {
        font = cfg.font.name;
        packages = [ cfg.font.package ];

        colors = builtins.map (color: lib.removePrefix "#" colors.${color}) cfg.colors;
      };
    };

  users = { ... }: {};
}
