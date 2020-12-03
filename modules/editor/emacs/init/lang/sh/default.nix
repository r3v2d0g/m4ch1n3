{ lib, pkgs, ucfg, ... }:

let
  flags = ucfg.editor.emacs.init.lang.sh.flags;
in {
  default = true;

  flags.fish = false;
  flags.lsp = false;
  flags.powershell = false;

  packages = [ pkgs.shellcheck ]
             ++ lib.optional flags.lsp pkgs.nodePacakges_latest.bash-language-server;
}
