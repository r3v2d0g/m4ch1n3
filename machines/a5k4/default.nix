{ config, ... }:

{
  base = {
    boot.device = "/dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0RLBSF";
    boot.modules = [ "wl" ];
    boot.packages = [ config.boot.kernelPackages.broadcom_sta ];

    luks.keys."a5k4-keys".device = "/dev/disk/by-partlabel/a5k4-keys";

    luks.devices."a5k4-part-1" = {
      device = "/dev/disk/by-partlabel/a5k4-part-1";

      key.name = "a5k4-keys";
      key.size = 4096;
      key.offset = 0;
    };

    luks.devices."a5k4-part-2" = {
      device = "/dev/disk/by-partlabel/a5k4-part-2";

      key.name = "a5k4-keys";
      key.size = 4096;
      key.offset = 4096;
    };

    fs.boot = "/dev/disk/by-uuid/436A-302E";

    net.host.name = "a5k4";
    net.host.id = "a0abe6f6";
    net.interfaces = [ "enp60s0" ];

    kb.ergodox = true;
  };

  dev.enable = true;

  db.enable = true;
  db.pg.enable = true;

  security = {
    yubico.enable = true;

    ssh.server = true;
    ssh.addr = "192.168.1.2";

    fw.ports = [ 5900 ];
  };

  users.eqs.enable = true;
  users.r3v2d0g = {
    enable = true;
    password = "local";

    comm.enable = true;
    comm.discord = true;
    comm.slack = true;
    dev.cypress = true;
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

    outputs."HDMI-A-2" = {
      resolution.width = 1920;
      resolution.height = 1080;

      rotation = 90;

      position.x = 3840;
      position.y = 2160 - 1920;
    };

    outputs."eDP-1" = {
      resolution.width = 1920;
      resolution.height = 1080;

      position.x = 3840 / 2 - 1920 / 2;
      position.y = 2160;
    };
  };
}
