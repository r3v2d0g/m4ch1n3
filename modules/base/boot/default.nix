{
  machine = { lib, modulesPath, mcfg, ... }:
    let
      cfg = mcfg.base.boot;
    in {
      options.m4ch1n3.base.boot = {
        bootloader = lib.mkOptBool true;
        device = lib.mkOptStr null;
        modules = lib.mkOptStrList [];
        packages = lib.mkOptPkgList [];
        amd = lib.mkOptBool false;
      };

      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      config.boot = lib.mkIf cfg.bootloader {
        loader.efi.canTouchEfiVariables = true;
        loader.grub = {
          enable = true;
          enableCryptodisk = true;

          copyKernels = true;
          efiSupport = true;
          zfsSupport = true;

          device = cfg.device;
        };

        initrd.availableKernelModules = [
          "nvme" "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"
        ] ++ lib.optional (! cfg.amd) "aesni_intel";

        kernelModules = cfg.modules
                        ++ (if cfg.amd
                            then [ "kvm-amd" ]
                            else [ "kvm-intel" ]);
        extraModulePackages = cfg.packages;

        kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
      };
    };

  users = { ... }: {};
}
