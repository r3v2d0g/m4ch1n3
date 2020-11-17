{ pkgs, ... }:

{ flags = [];

  packages =
    [ pkgs.gcc
      pkgs.gnumake
      pkgs.libvterm
    ];
}
