{ rtl8723de, vetur, waybar, ... }:

self: super:

{ emacsGcc = super.emacsGcc
    .overrideAttrs
    (prev:
      { patches =
          (prev.patches or [])
          ++ [ ./patches/emacsGcc/0001-emacsgcc-fix-doom-emacs-install.patch ];
      }
    );

  rtl8723de = self.callPackage ./rtl8723de
    { source = rtl8723de;
      kernel = self.linux;
    };

  vls = (self.callPackage "${vetur}/server" {}).package;

  waybar = super.waybar
    .overrideAttrs
    (prev:
      { src = waybar;
        version = "0.9.5";

        patches =
          (prev.patches or [])
          ++ [ ./patches/waybar/0001-no-exclusive-zone-for-overlay.patch ];

        mesonFlags = prev.mesonFlags ++ [ "-Dsndio=disabled" ];
      }
    );
}
