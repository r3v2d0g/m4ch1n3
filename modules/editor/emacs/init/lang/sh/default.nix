{ config, lib, pkgs, ... }:

let flags = config.m4ch1n3.editor.emacs.init.lang.sh.flags;

in { flags =
       [ "fish"
         "lsp"
         "powershell"
       ];

     packages = [ pkgs.shellcheck ]
                ++ lib.optional flags.lsp pkgs.nodePacakges_latest.bash-language-server;
}
