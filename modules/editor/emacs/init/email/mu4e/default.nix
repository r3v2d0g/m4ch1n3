{ pkgs, ... }:

{
  default = false;

  flags.gmail = false;

  packages = [ pkgs.isync pkgs.mu ];
}
