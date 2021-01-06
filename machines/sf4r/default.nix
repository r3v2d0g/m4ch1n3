{ config, pkgs, ... }:

{
  base = {
    boot.device = "/dev/disk/by-id/ata-INTEL_SSDSCKKF256G8H_BTLA7452075L256J";
    boot.modules = [ "rtl8723de" ];
    boot.packages = [ pkgs.rtl8723de ];

    luks.devices."sf4r".device = "/dev/disk/by-partlabel/sf4r";

    fs.boot = "/dev/disk/by-uuid/CBCB-4D7F";

    net.host.name = "sf4r";
    net.host.id = "41b22822";
    net.interfaces = [ "eno1" ];
    net.netman = true;
    net.idevice = true;
  };

  dev.enable = true;

  db.enable = true;
  db.pg.enable = true;

  security = {
    yubico.enable = true;

    ssh.server = true;
    ssh.addr = "192.168.1.2";
  };

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

    primary = "eDP-1";
    outputs."eDP-1" = {
      resolution.width = 1920;
      resolution.height = 1080;

      position.x = 0;
          position.y = 0;
    };
  };
}
