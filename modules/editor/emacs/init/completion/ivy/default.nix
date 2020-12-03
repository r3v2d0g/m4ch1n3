{ pkgs, ... }:

{
  default = true;

  flags.childframe = false;
  flags.fuzzy = false;
  flags.icons = false;
  flags.prescient = false;

  packages = [ pkgs.ripgrep ];
}
