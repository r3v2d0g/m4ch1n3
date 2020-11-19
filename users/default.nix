{ config, inputs, lib, ... }:

let user = path: { pkgs, ... }@args: import path (args // { inherit lib; });

    enabledUsers = lib.filterAttrs
      (_: { enable, ... }: enable)
      config.m4ch1n3.users;

    modules = args:
      (import ../modules).users
        (args // { inherit inputs lib;
                   mconfig = config;
                 });

in { imports =
       [ inputs.home-manager.nixosModules.home-manager

         (user ./r3v2d0g)
         (user ./root)
       ];

     home-manager.users = lib.mapAttrs
       (_: _: modules)
       enabledUsers;

     users.mutableUsers = false;

     home-manager.useGlobalPkgs = true;
     home-manager.useUserPackages = true;
   }
