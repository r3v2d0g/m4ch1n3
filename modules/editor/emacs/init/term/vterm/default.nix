{ pkgs, ... }:

{
  default = true;

  flags = {};

  packages = [
    pkgs.gcc
    pkgs.gnumake
    pkgs.libvterm
  ];
}
