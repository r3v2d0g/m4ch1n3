{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.base.kb;

      ergodox = ''
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
      '';

      planck = ''
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
            MODE:="0666", \
            SYMLINK+="stm32_dfu"
      '';
    in {
      options.m4ch1n3.base.kb = {
        ergodox = lib.mkOptBool false;
        planck = lib.mkOptBool false;
      };

      config.services.udev.extraRules = ''
        ${lib.optionalString cfg.ergodox ergodox}
        ${lib.optionalString cfg.planck planck}
      '';
    };

  users = { ... }: {};
}
