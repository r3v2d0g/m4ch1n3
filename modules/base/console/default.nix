{ machine = { config, ... }:
    { services.mingetty =
        { greetingLine =
            ''<<< \l on \n running NixOS ${config.system.nixos.version} >>>'';

          helpLine = "";
        };
    };

  users = { ... }: {};
}
