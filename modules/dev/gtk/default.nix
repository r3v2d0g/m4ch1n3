{
  machine = { ... }: {};

  users = { config, lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev.gtk;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && ucfg.dev.build.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.gtk.enable = lib.mkOptBool true;

      config = lib.mkIf enable {
        m4ch1n3.dev.build.extraPkgConfigPaths = [
          "${pkgs.atk.dev}/lib/pkgconfig"
          "${pkgs.cairo.dev}/lib/pkgconfig"
          "${pkgs.gdk-pixbuf.dev}/lib/pkgconfig"
          "${pkgs.glib.dev}/lib/pkgconfig"
          "${pkgs.graphene}/lib/pkgconfig"
          "${pkgs.gtk3.dev}/lib/pkgconfig"
          "${pkgs.harfbuzz.dev}/lib/pkgconfig"
          "${pkgs.pango.dev}/lib/pkgconfig"
          "${pkgs.wayland}/lib/pkgconfig"
        ];
      };
    };
}
