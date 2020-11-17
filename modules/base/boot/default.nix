{ machine = { config, lib, modulesPath, ... }:
    let cfg = config.m4ch1n3.base.boot;

    in { options.m4ch1n3.base.boot =
           { bootloader = lib.mkDisableOption "bootloader";

             device = lib.mkStrOption {};

             modules = lib.mkListOfStrOption
                 { default = []; };

             packages = lib.mkListOfStrOption
                 { default = []; };
           };

         imports =
           [ (modulesPath + "/installer/scan/not-detected.nix") ];

         config =
           { boot.loader = lib.mkIf cfg.bootloader
               { efi.canTouchEfiVariables = true;

                 grub =
                     { enable = true;
                       enableCryptodisk = true;

                       copyKernels = true;
                       efiSupport = true;
                       zfsSupport = true;

                       device = cfg.device;
                     };
               };

             boot.initrd.availableKernelModules = lib.mkIf cfg.bootloader
               [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"
                 "aes_x86_64" "aesni_intel"
               ];

             boot.kernelModules =
               [ "kvm-intel" ];
           };
       };

  users = { ... }: {};
}
