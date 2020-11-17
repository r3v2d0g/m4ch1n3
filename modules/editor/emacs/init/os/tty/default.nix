{ config, lib, pkgs, ... }:

{ flags = [ "osc" ];

  packages = [ pkgs.wl-clipboard ];
}
