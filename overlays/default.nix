{ fmt
, nixpkgs-mesa
, paper-icon-theme
, rtl8723de
, waybar
, ...
}:

self: super:

{
  emacsGcc = super.emacsGcc .overrideAttrs (prev: {
    patches = (prev.patches or [])
              ++ [ ./patches/emacsGcc/0001-emacsgcc-fix-doom-emacs-install.patch ];
  });

  fmt = super.fmt.overrideAttrs (prev: {
    src = fmt;
    version = "7.0.3";
  });

  mesa_drivers = (import nixpkgs-mesa { system = "x86_64-linux"; }).mesa_drivers;

  paper-icon-theme = super.paper-icon-theme.overrideAttrs (_: {
    src = paper-icon-theme;
    version = "2020-03-12";
  });

  rtl8723de = self.callPackage ./rtl8723de {
    src = rtl8723de;
    kernel = self.linux;
  };

  waybar = super.waybar.overrideAttrs (prev: {
    src = waybar;
    version = "0.9.5";

    patches = (prev.patches or []) ++ [
      ./patches/waybar/0001-no-exclusive-zone-for-overlay.patch
    ];

    mesonFlags = prev.mesonFlags ++ [ "-Dsndio=disabled" ];
  });
}
