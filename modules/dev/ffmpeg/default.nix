{
  machine = { ... }: {};

  users = { lib, mcfg, ucfg, pkgs, ... }:
    let
      cfg = ucfg.dev.ffmpeg;
      enable = mcfg.dev.enable && ucfg.dev.enable
               && ucfg.dev.build.enable
               && cfg.enable;
    in {
      options.m4ch1n3.dev.ffmpeg.enable = lib.mkOptBool true;

      config = lib.mkIf enable {
        m4ch1n3.dev.build.extraPkgConfigPaths = [
          "${pkgs.ffmpeg.dev}/lib/pkgconfig"
        ];
      };
    };
}
