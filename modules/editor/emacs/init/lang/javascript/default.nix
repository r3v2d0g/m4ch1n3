{ lib, mcfg, pkgs, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && (ucfg.dev.nodejs.enable || ucfg.dev.typescript.enable || ucfg.dev.vuejs.enable);
  flags = ucfg.editor.emacs.modules.lang.javascript.flags;
in {
  inherit default;

  flags.lsp = true;

  packages = lib.optional flags.lsp pkgs.nodePackages.typescript-language-server;
}
