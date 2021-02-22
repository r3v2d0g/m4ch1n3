{
  machine = { config, ... }: {
    services.getty = {
      greetingLine = ''<<< \l on \n running NixOS ${config.system.nixos.version} >>>'';
      helpLine = "";
    };
  };

  users = { ... }: {};
}
