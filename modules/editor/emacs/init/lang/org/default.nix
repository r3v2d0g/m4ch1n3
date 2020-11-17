{ config, lib, pkgs, ... }:

let flags = config.m4ch1n3.editor.emacs.init.lang.org.flags;

in { flags =
       [ "brain"
         "dragndrop"
         "gnuplot"
         "hugo"
         "journal"
         "noter"
         "pandoc"
         "pomodoro"
         "present"
         "pretty"
         "roam"
       ];

     packages = [ pkgs.texlive.combined.scheme-medium ]
                ++ lib.optional flags.gnuplot pkgs.gnuplot
                ++ lib.optional flags.roam pkgs.sqlite;
   }
