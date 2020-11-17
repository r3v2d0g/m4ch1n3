{ config, inputs, lib, ... }:

let user = path: { lib, pkgs, ... }@args:
      import path
        (args // { lib = import ../lib { inherit lib; }; });

    enabledUsers = lib.filterAttrs
      (_: { enable, ... }: enable)
      config.m4ch1n3.users;

    modules = { lib, ... }@args:
      (import ../modules).users
        (args // { inherit inputs;
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
