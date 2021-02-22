{ pkgs, ... }:

{
  default = true;

  flags.latexmk = false;
  flags.cdlatex = true;
  flags.lsp = true;
  flags.fold = true;

  packages = [ pkgs.texlive.combined.scheme-medium ];
}
