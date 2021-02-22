{ pkgs, ... }:

{
  default = true;

  flags = {};

  packages = [
    pkgs.gnumake
    pkgs.libvterm
  ];
}
