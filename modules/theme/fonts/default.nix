{
  machine = { lib, mcfg, pkgs, ... }:
    let
      cfg = mcfg.theme.fonts;
    in {
      options.m4ch1n3.theme.fonts = {
        default = lib.mkOptFont "Noto Sans Mono" pkgs.noto-fonts;
        sans = lib.mkOptFont "Noto Sans" pkgs.noto-fonts;
        serif = lib.mkOptFont "Noto Serif" pkgs.noto-fonts;
        mono = lib.mkOptFont "Noto Sans Mono" pkgs.noto-fonts;
        code = lib.mkOptFont "JetBrains Mono" pkgs.jetbrains-mono;
        emoji = lib.mkOptFont "JoyPixels" pkgs.joypixels;
      };

      config.fonts = lib.mkIf mcfg.wm.enable {
        fontconfig = {
          enable = true;

          defaultFonts.sansSerif = [ cfg.sans.name ];
          defaultFonts.serif = [ cfg.serif.name ];
          defaultFonts.monospace = [ cfg.mono.name ];
          defaultFonts.emoji = [ cfg.emoji.name ];
        };

        fontDir.enable = true;

        fonts = lib.mapAttrsValues (_: font: font.package) cfg;
      };
    };

  users = { ... }: {};
}
