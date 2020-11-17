{ machine = { config, lib, pkgs, ... }:
    let cfg = config.m4ch1n3.theme.fonts;

    in { options.m4ch1n3.theme.fonts =
           { default = lib.mkFontOption "Noto Sans Mono" pkgs.noto-fonts;
             sans = lib.mkFontOption "Noto Sans" pkgs.noto-fonts;
             serif = lib.mkFontOption "Noto Serif" pkgs.noto-fonts;
             mono = lib.mkFontOption "Noto Sans Mono" pkgs.noto-fonts;
             code = lib.mkFontOption "JetBrains Mono" pkgs.jetbrains-mono;
             emoji = lib.mkFontOption "JoyPixels" pkgs.joypixels;
           };

         config.fonts = lib.mkIf config.m4ch1n3.wm.enable
           { fontconfig =
               { enable = true;

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
