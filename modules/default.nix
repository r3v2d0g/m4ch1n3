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

        ./mail
        ./mail/pm

        ./security
        ./security/pass
        ./security/yubico

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
           (mod: { pkgs, ... }@args:
             (import mod).machine (args // { inherit inputs lib; })
           ) modules;
       };

     users = { inputs, lib, mconfig, ... }:
       { imports = builtins.map
           (mod: { pkgs, ... }@args:
             (import mod).users (args // { inherit inputs lib mconfig; })
           ) modules;
       };
   }
