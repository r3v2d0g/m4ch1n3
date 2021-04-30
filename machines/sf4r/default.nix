{ config, pkgs, ... }:

{
  base.boot = {
    device = "/dev/disk/by-id/ata-INTEL_SSDSCKKF256G8H_BTLA7452075L256J";

    modules = [ "rtl8723de" ];
    packages = [ pkgs.rtl8723de ];
  };

  base.fs = {
    boot = "/dev/disk/by-uuid/CBCB-4D7F";
  };

  base.kb.planck = true;

  base.luks.devices."sf4r".device = "/dev/disk/by-partlabel/sf4r";

  base.net = {
    host.name = "sf4r";
    host.id = "41b22822";
    interfaces = [ "eno1" ];
    netman = true;
    idevice = true;
  };

  dev.enable = true;

  db = {
    enable = true;
    pg.enable = true;
  };

  security.ledger.enable = true;
  security.yubico.enable = true;

  security.ssh = {
    server = true;
    addr = "192.168.1.3";
  };

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

    primary = "eDP-1";
    outputs."eDP-1" = {
      resolution.width = 1920;
      resolution.height = 1080;

      position.x = 0;
      position.y = 0;
    };
  };
}
