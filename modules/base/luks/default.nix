{
  machine = { lib, mcfg, ... }:
    let
      cfg = mcfg.base.luks;

      msg = with lib.term;
        let
          device = name: ''${clear.line.all}${cursor.col 1}LUKS device ${fmt.weight.bold}${name}${fmt.reset}:'';
          yellow = msg: name: ''${device name} ${fmt.fg.set colors.yellow}${msg}${fmt.fg.default}'';
          green = msg: name: ''${device name} ${fmt.fg.set colors.green}${msg}${fmt.fg.default}'';
          red = msg: name: ''${device name} ${fmt.fg.set colors.red}${msg}${fmt.fg.default}'';
        in {
          opening = yellow "opening";
          opened = green "opened";

          closing = yellow "closing";
          closed = red "closed";

          waiting = yellow "waiting";
          pass = red "password required";
          wrong = red "wrong password";
        };

      openKey = key: dev:
        with lib.term;
        let
          device = cfg.keys.${key}.device;
        in ''
          do_open_key() {
              local passphrase

              echo -e "${msg.waiting dev}"
              echo -e "${msg.pass key}"

              while true; do
                  echo -en "Password for ${fmt.weight.bold}${key}${fmt.reset}: "
                  passphrase=

                  while true; do
                      echo -n "${device}" > /crypt-ramfs/device

                      IFS= read -t 1 -r passphrase
                      if [ -n "$passphrase" ]; then
                          break
                      fi
                  done

                  echo -en "${clear.line.all}${cursor.up 1}${msg.opening key}"
                  echo -n "$passphrase" | cryptsetup luksOpen ${device} ${key} --key-file=- >/dev/null 2>/dev/null

                  if [ $? == 0 ]; then
                      echo -en "${clear.line.all}${cursor.up 1}${msg.opening dev}"
                      rm -f /crypt-ramfs/passphrase
                      break
                  else
                      echo -e "${msg.wrong key}"
                      rm -f /crypt-ramfs/passphrase
                  fi
              done
          }

          if ! dev_exist /dev/mapper/${key}; then
              do_open_key
          fi
        '';

      closeKey = key:
        let
          devices = lib.concatMapStringsNl
            (dev: ''
              if ! dev_exist /dev/mapper/${dev}; then
                  break
              fi
            '') (lib.filterAttrsNames (_: dev: dev.key.name == key) cfg.devices);
        in ''
          while true; do
              if ! dev_exist /dev/mapper/${key}; then
                  break
              fi

              ${devices}

              echo -en "${msg.closing key}"
              cryptsetup close ${key}

              if [ $? == 0 ]; then
                  echo -e "${msg.closed key}"
              else
                  die "Failed to close LUKS device ${key}"
              fi
          done
        '';
    in {
      options.m4ch1n3.base.luks = {
        keys = lib.mkOptSubmodAttrs { device = lib.mkOptStr null; } {};
        devices = lib.mkOptSubmodAttrs {
          device = lib.mkOptStr null;

          key.name = lib.mkOptEnumFromNull cfg.keys null;
          key.size = lib.mkOptInt null;
          key.offset = lib.mkOptInt null;
        } {};
      };

      config.boot.initrd.luks.devices = lib.mapAttrs
        (_: { name, device, key }:
          { inherit name device;

            preOpenCommands = ''
              echo -en "${msg.opening name}"
              ${lib.optionalString (! isNull key.name) (openKey key.name name)}
            '';

            postOpenCommands = ''
              echo -e "${msg.opened name}"
              ${lib.optionalString (! isNull key.name) (closeKey key.name)}
            '';
          } // lib.optionalAttrs (! isNull key.name) {
            keyFile = "/dev/mapper/${key.name}";
            keyFileSize = key.size;
            keyFileOffset = key.offset;
          }
        ) cfg.devices;
    };

  users = { ... }: {};
}
