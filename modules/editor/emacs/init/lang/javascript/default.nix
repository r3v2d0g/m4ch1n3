{ config, lib, pkgs, ... }:

let flags = config.m4ch1n3.editor.emacs.init.lang.javascript.flags;

in { flags = [ "lsp" ];

     packages =
       [ pkgs.nodejs
         pkgs.nodePackages.npm
         pkgs.yarn
       ]
       ++ lib.optionals flags.lsp
         [ pkgs.nodePackages.typescript-language-server
           pkgs.vls
         ];
}
