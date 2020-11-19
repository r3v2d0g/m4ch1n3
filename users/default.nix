{ config, inputs, lib, ... }:

let user = path: { pkgs, ... }@args: import path (args // { inherit lib; });

    modules = args:
      (import ../modules).users
        (args // { inherit inputs lib;
                   mconfig = config;
                 });

in { imports =
       [ inputs.home-manager.nixosModules.home-manager

         (user ./all)
         (user ./r3v2d0g)
         (user ./root)
       ];

     home-manager.users = lib.mapFilterAttrs
       (_: _: modules)
       (_: { enable ? false, ... }: enable)
       config.m4ch1n3.users;

     users.mutableUsers = false;

     home-manager.useGlobalPkgs = true;
     home-manager.useUserPackages = true;
   }
