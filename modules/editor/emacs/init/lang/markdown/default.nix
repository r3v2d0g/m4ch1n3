{ pkgs, ... }:

{
  default = true;

  flags.grip = false;

  packages = [
    pkgs.mdl
    pkgs.pandoc
    pkgs.proselint
  ];
}
