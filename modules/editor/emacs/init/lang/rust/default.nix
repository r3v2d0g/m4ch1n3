{ lib, mcfg, pkgs, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && ucfg.dev.rust.enable;
  flags = ucfg.editor.emacs.init.lang.rust.flags;
in {
  inherit default;

  flags.lsp = true;

  packages = lib.optional flags.lsp pkgs.rust-analyzer;
}
