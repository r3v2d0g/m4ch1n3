{ pkgs, ... }:

{
  default = true;

  flags.osc = true;

  packages = [ pkgs.wl-clipboard ];
}
