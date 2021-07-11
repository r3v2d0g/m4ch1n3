{ lib, mcfg, pkgs, ucfg, ... }:

let
  default = mcfg.dev.enable && ucfg.dev.enable
            && ucfg.dev.elixir.enable;
  flags = ucfg.editor.emacs.modules.lang.elixir.flags;
in {
  default = true;

  flags.lsp = true;

  packages = [
    pkgs.elixir
  ] ++ lib.optional flags.lsp pkgs.elixir_ls;
}
