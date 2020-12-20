{ nixpkgs-mesa
, proton-bridge
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

  mesa_drivers = (import nixpkgs-mesa { system = "x86_64-linux"; }).mesa_drivers;

  protonmail-bridge = self.callPackage ./protonmail-bridge { source = proton-bridge; };

  rtl8723de = self.callPackage ./rtl8723de {
    source = rtl8723de;
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
