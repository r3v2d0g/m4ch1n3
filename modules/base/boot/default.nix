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
          "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"
          "aes_x86_64" "aesni_intel"
        ];

        kernelModules = [ "kvm-intel" ] ++ cfg.modules;
        extraModulePackages = cfg.packages;
      };
    };

  users = { ... }: {};
}
