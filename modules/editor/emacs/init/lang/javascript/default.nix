{ lib, mcfg, pkgs, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && (ucfg.dev.nodejs.enable || ucfg.dev.typescript.enable || ucfg.dev.vuejs.enable);
  flags = ucfg.editor.emacs.init.lang.javascript.flags;
in {
  inherit default;

  flags.lsp = true;

  packages = [
    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.yarn
  ] ++ lib.optional flags.lsp pkgs.nodePackages.typescript-language-server;
}
