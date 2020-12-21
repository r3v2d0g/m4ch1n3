{
  machine = { ... }: {};

  users = { pkgs, ... }: {
    programs.vim = {
      enable = true;
      settings = {
        expandtab = true;
        shiftwidth = 2;
      };

      plugins = [
        pkgs.vimPlugins.vim-nix
      ];
    };
  };
}
