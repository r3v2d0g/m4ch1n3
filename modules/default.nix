let modules =
      [ ./base
        ./base/boot
        ./base/console
        ./base/fs
        ./base/luks
        ./base/net

        ./dev
        ./dev/haskell
        ./dev/nodejs
        ./dev/python
        ./dev/rust
        ./dev/typescript
        ./dev/vuejs

        ./editor
        ./editor/emacs
        ./editor/emacs/init

        ./gpg

        ./shell
        ./shell/git
        ./shell/ssh

        ./theme
        ./theme/console
        ./theme/fonts
        ./theme/grub
        ./theme/wm
        ./theme/wm/1password
        ./theme/wm/bar
        ./theme/wm/term

        ./wm
        ./wm/1password
        ./wm/audio
        ./wm/bar
        ./wm/browser
        ./wm/term
      ];

in { machine = { inputs, lib, ... }:
       { imports = builtins.map
         (mod: { lib, pkgs, ... }@args:
             (import mod).machine
               (args // { inherit inputs;
                          lib = import ../lib { inherit lib; };
                        }
               )
           ) modules;
       };

     users = { inputs, mconfig, ... }:
       { imports = builtins.map
           (mod: { lib, pkgs, ... }@args:
             (import mod).users
               (args // { inherit inputs mconfig;
                          lib = import ../lib { inherit lib; };
                        }
               )
           ) modules;
       };
   }
