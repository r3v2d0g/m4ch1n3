args:

{
  agda = null;
  cc = null;
  clojure = null;
  common-lisp = import ./common-lisp args;
  coq = null;
  crystal = null;
  csharp = null;
  dart = null;
  data = import ./data args;
  elixir = null;
  elm = null;
  emacs-lisp = import ./emacs-lisp args;
  erlang = null;
  ess = null;
  factor = null;
  faust = null;
  fsharp = null;
  fstar = null;
  gdscript = null;
  go = null;
  haskell = import ./haskell args;
  hy = null;
  idris = null;
  java = null;
  javascript = import ./javascript args;
  json = import ./json args;
  julia = import ./julia args;
  kotlin = null;
  latex = import ./latex args;
  lean = null;
  ledger = import ./ledger args;
  lua = null;
  markdown = import ./markdown args;
  nim = null;
  nix = import ./nix args;
  ocaml = import ./ocaml args;
  org = import ./org args;
  php = null;
  plantuml = null;
  purescript = null;
  python = import ./python args;
  qt = null;
  racket = null;
  raku = null;
  rest = null;
  rst = null;
  ruby = null;
  rust = import ./rust args;
  scala = null;
  scheme = null;
  sh = import ./sh args;
  sml = null;
  solidity = null;
  swift = null;
  terra = null;
  web = import ./web args;
  yaml = import ./yaml args;
}
