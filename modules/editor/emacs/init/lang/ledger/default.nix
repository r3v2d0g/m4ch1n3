{ pkgs, ... }:

{
  default = false;

  flags = {};

  packages = [ pkgs.ledger ];
}
