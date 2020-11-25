{ config, pkgs, ... }:

{ base =
    { boot.device = "/dev/disk/by-id/ata-INTEL_SSDSCKKF256G8H_BTLA7452075L256J";
      boot.packages = [ pkgs.rtl8723de ];

      luks.devices."sf4r" =
        { device = "/dev/disk/by-partlabel/sf4r"; };

      fs.boot = "/dev/disk/by-uuid/CBCB-4D7F";

      net.host.name = "sf4r";
      net.host.id = "41b22822";
      net.interfaces = [ "eno1" ];
    };

  gpg.yubikey = true;
  security.yubico.enable = true;

  security.ssh =
    { enable = true;
      address = "192.168.1.4";
    };

  users.r3v2d0g =
    { enable = true;
      password = "local";

      comm.enable = true;
      security.pass.enable = true;

      wm.autostart.enable = true;
      wm.onepassword.enable = true;
    };

  wm =
    { enable = true;

      primary = "eDP-1";
      outputs."eDP-1" =
        { resolution.width = 1920;
          resolution.height = 1080;

          position.x = 0;
          position.y = 0;
        };
    };
}
