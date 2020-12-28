let
  modules = [
    ./base
    ./base/boot
    ./base/console
    ./base/fs
    ./base/hm
    ./base/kb
    ./base/luks
    ./base/net

    ./comm
    ./comm/discord
    ./comm/pm
    ./comm/slack

    ./db
    ./db/pg

    ./dev
    ./dev/build
    ./dev/cypress
    ./dev/docker
    ./dev/gtk
    ./dev/haskell
    ./dev/jetbrains
    ./dev/lisp
    ./dev/nodejs
    ./dev/python
    ./dev/rust
    ./dev/typescript
    ./dev/vuejs

    ./editor
    ./editor/emacs
    ./editor/emacs/init
    ./editor/vim

    ./security
    ./security/fw
    ./security/gpg
    ./security/pass
    ./security/ssh
    ./security/yubico

    ./shell
    ./shell/git

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
in {
  machine = { inputs, lib, ... }: {
    imports = builtins.map (mod: { config, pkgs, utils, ... }@args:
        (import mod).machine (args // {
            inherit inputs lib;
            mcfg = config.m4ch1n3;
        })
    ) modules;
  };

  users = { config, inputs, lib, mconfig, ... }: {
    imports = builtins.map (mod: { pkgs, ... }@args:
        (import mod).users (args // {
            inherit inputs lib mconfig;
            ucfg = config.m4ch1n3;
            mcfg = mconfig.m4ch1n3;
        })
    ) modules;
  };
}
