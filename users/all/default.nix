{ config, lib, pkgs, ... }:

let mcfg = config.m4ch1n3;

in { home-manager.users = lib.mapFilterAttrs
       (_: _: _:
         { m4ch1n3.editor.emacs.init =
             { checkers.syntax.enable = true;

               completion.company.enable = true;
               completion.ivy.enable = true;

               config.default.enable = true;
               config.default.flags.bindings = true;
               config.default.flags.smartparens = true;

               editor.evil.enable = true;
               editor.evil.flags.everywhere = true;
               editor.format.enable = true;
               editor.word-wrap.enable = true;

               emacs.dired.enable = true;
               emacs.undo.enable = true;
               emacs.vc.enable = true;

               email.mu4e.enable = true;

               lang.data.enable = true;
               lang.emacs-lisp.enable = true;
               lang.haskell.enable = true;
               lang.haskell.flags.lsp = true;
               lang.javascript.enable = true;
               lang.javascript.flags.lsp = true;
               lang.json.enable = true;
               lang.markdown.enable = true;
               lang.nix.enable = true;
               lang.org.enable = true;
               lang.org.flags.pretty = true;
               lang.python.enable = true;
               lang.python.flags.lsp = true;
               lang.rust.enable = true;
               lang.rust.flags.lsp = true;
               lang.sh.enable = true;
               lang.web.enable = true;
               lang.yaml.enable = true;

               os.tty.enable = true;
               os.tty.flags.osc = true;

               term.vterm.enable = true;

               tools.magit.enable = true;
               tools.lsp.enable = true;

               ui.doom.enable = true;
               ui.doom-dashboard.enable = true;
               ui.hl-todo.enable = true;
               ui.hydra.enable = true;
               ui.ligatures.enable = true;
               ui.modeline.enable = true;
               ui.nav-flash.enable = true;
               ui.ophints.enable = true;
               ui.popup.enable = true;
               ui.popup.flags.defaults = true;
               ui.treemacs.enable = true;
               ui.vc-gutter.enable = true;
               ui.vi-tilde-fringe.enable = true;
             };
         }
       ) (_: { enable ? false, ... }: enable) mcfg.users;

     users.users = lib.mapFilterAttrs
       (_: _: { shell = pkgs.zsh; })
       (_: { enable ? false, ... }: enable) mcfg.users;
   }
