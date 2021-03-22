{ config, ... }:

{
  base.boot.device = "/dev/disk/by-id/nvme-eui.00253857019e8522";

  base.fs = {
    pool = "a5k4-root";
    boot = "a5k4-boot/boot";
    efi = "/dev/disk/by-id/nvme-eui.00253857019e8522-part2";
  };

  base.kb.ergodox = true;

  base.luks =
    let
      a5k4-root = n: {
        device = "/dev/disk/by-partlabel/a5k4-root-${toString n}";

        key.name = "a5k4-keys";
        key.size = 4096;
        key.offset = n * 4096;
      };
    in {
      keys."a5k4-keys".device = "/dev/disk/by-partlabel/a5k4-keys";

      devices."a5k4-root-0" = a5k4-root 0;
      devices."a5k4-root-1" = a5k4-root 1;
      devices."a5k4-root-2" = a5k4-root 2;
    };

  base.net = {
    host.name = "a5k4";
    host.id = "7fabb554";
    interfaces = [ "enp4s0" "wlp7s0" ];
    netman = true;
  };

  dev.enable = true;

  db = {
    enable = true;
    pg.enable = true;
  };

  security.ledger.enable = true;
  security.yubico.enable = true;

  users.r3v2d0g = {
    enable = true;

    uid = 100;
    password = "local";

    comm = {
      enable = true;
      discord = true;
      slack = true;
    };

    dev.cypress = true;
    shell.mega = true;
    theme.wm.term.fontSize = "9.0";
    wm.autostart = true;
  };

  wm = {
    enable = true;

    primary = "DP-1";
    outputs."DP-1" = {
      resolution.width = 3840;
      resolution.height = 2160;

      position.x = 0;
      position.y = 0;
    };
  };
}
