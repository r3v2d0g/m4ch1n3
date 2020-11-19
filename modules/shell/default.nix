{ machine = { ... }: {};

  users = { config, inputs, lib, pkgs, ... }:
    { home.packages =
        [ pkgs.bat
          pkgs.bottom
          pkgs.du-dust
          pkgs.exa
          pkgs.fzf
          pkgs.htop
          pkgs.jq
          pkgs.p7zip
          pkgs.wget
        ];

      programs.zsh =
        { enable = true;
          enableAutosuggestions = true;
          enableCompletion = true;

          autocd = true;
          defaultKeymap = "emacs";

          history.ignoreDups = true;
          history.ignoreSpace = true;

          oh-my-zsh =
            { enable = true;
              plugins = [ "sudo" ];
            };

          plugins =
            [ { name = "jq-zsh-plugin";
                file = "jq.plugin.zsh";
                src = inputs.jq-zsh-plugin;
              }

              { name = "zsh-autopair";
                file = "autopair.plugin.zsh";
                src = inputs.zsh-autopair;
              }

              { name = "zsh-bd";
                file = "bd.zsh";
                src = inputs.zsh-bd;
              }

              { name = "zsh-nix-shell";
                file = "nix-shell.plugin.zsh";
                src = inputs.zsh-nix-shell;
              }

              { name = "zsh-syntax-highlighting";
                src = inputs.zsh-syntax-highlighting;
              }
            ];

          envExtra =
            ''
               PATH="$HOME/.yarn/bin:$PATH";
            '';

          initExtraBeforeCompInit =
            ''
               setopt PROMPT_SUBST
            '';

          sessionVariables =
            { "PROMPT"  = " %B%F{11}%n%f@%F{13}%M%f:%F{12}%3~ %f%b ";
              "RPROMPT" = "%F{12}\\\${IN_NIX_SHELL[1]} %(?.%F{7}.%F{9})\\$(printf \"%03d\" \\$?)%f ";

              "ALTERNATE_EDITOR" = "emacs";
              "EDITOR" = "emacsclient -c";

              "ZSH_AUTOSUGGEST_USE_ASYNC" = true;
              "ZSH_AUTOSUGGEST_STRATEGY" = [ "match_prev_cmd" "completion" ];
              "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" = "fg=7";
            };

          shellAliases =
            { "c" = "clear";
              "em" = "emacs";
              "emc" = "emacsclient --no-wait";
              "emt" = "emacs -nw";

              "du" = "${pkgs.du-dust}/bin/dust";
              "l"    = "${pkgs.exa}/bin/exa -l";
              "ls"   = "${pkgs.exa}/bin/exa";
              "quit" = "exit";
              "tree" = "${pkgs.exa}/bin/exa -T";
            } // lib.optionalAttrs
              (config.m4ch1n3.wm.enable && config.m4ch1n3.wm.term.enable)
              { "icat" = "kitty +kitten icat"; };
        };
    };
}
