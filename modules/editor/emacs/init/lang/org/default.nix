{ lib, pkgs, ucfg, ... }:

let
  flags = ucfg.editor.emacs.init.lang.org.flags;
in {
  default = true;

  flags.brain = false;
  flags.dragndrop = false;
  flags.gnuplot = false;
  flags.hugo = false;
  flags.journal = false;
  flags.noter = false;
  flags.pandoc = false;
  flags.pomodoro = false;
  flags.present = false;
  flags.pretty = true;
  flags.roam = false;

  packages = [ pkgs.texlive.combined.scheme-medium ]
             ++ lib.optional flags.gnuplot pkgs.gnuplot
             ++ lib.optional flags.roam pkgs.sqlite;
}
