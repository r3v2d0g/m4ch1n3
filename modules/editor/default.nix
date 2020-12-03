{
  machine = { ... }: {};

  users = { pkgs, ... }: { home.packages = [ pkgs.vim ]; };
}
