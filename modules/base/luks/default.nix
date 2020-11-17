{ machine = { config, lib, ... }:
    let cfg = config.m4ch1n3.base.luks;

        style =
          { reset = ''\e[0m'';
            progress = ''\e[33m'';
            success = ''\e[32m'';
            failure = ''\e[31m'';
            device = ''\e[1m'';
            clear = ''\e[2K\r'';
            up = ''\e[1A'';
          };

        msg =
          { opening = name:
              ''${style.clear}LUKS device ${style.device}${name}${style.reset}: ${style.progress}opening${style.reset}'';

            closing = name:
              ''${style.clear}LUKS device ${style.device}${name}${style.reset}: ${style.progress}closing${style.reset}'';

            opened = name:
              ''${style.clear}LUKS device ${style.device}${name}${style.reset}: ${style.success}opened${style.reset}'';

            closed = name:
              ''${style.clear}LUKS device ${style.device}${name}${style.reset}: ${style.failure}closed${style.reset}'';

            waiting = name:
              ''${style.clear}LUKS device ${style.device}${name}${style.reset}: ${style.progress}waiting on key${style.reset}'';

            pass = name:
              ''${style.clear}LUKS device ${style.device}${name}${style.reset}: ${style.failure}password required${style.reset}'';

            wrong = name:
              ''${style.clear}LUKS device ${style.device}${name}${style.reset}: ${style.failure}wrong password${style.reset}'';
          };

        openKey = key: dev:
          let device = cfg.keys.${key}.device;

          in ''
                do_open_key() {
                    local passphrase

                    echo -e "${msg.waiting dev}"
                    echo -e "${msg.pass key}"

                    while true; do
                        echo -en "Password for ${style.device}${key}${style.reset}: "
                        passphrase=

                        while true; do
                            echo -n "${device}" > /crypt-ramfs/device

                            IFS= read -t 1 -r passphrase
                            if [ -n "$passphrase" ]; then
                                break
                            fi
                        done

                        echo -en "${style.clear}${style.up}${msg.opening key}"
                        echo -n "$passphrase" | cryptsetup luksOpen ${device} ${key} --key-file=- >/dev/null 2>/dev/null

                        if [ $? == 0 ]; then
                            echo -en "${style.clear}${style.up}${msg.opening dev}"
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
          ''
             while true; do
                 if ! dev_exist /dev/mapper/${key}; then
                     break
                 fi

                 ${lib.concatMapStringsNl
                     (dev:
                       ''
                          if ! dev_exist /dev/mapper/${dev}; then
                              break
                          fi
                       ''
                     )
                     (lib.filterAttrsNames
                       (_: dev: dev.key.name == key)
                       cfg.devices
                     )
                  }


                  echo -en "${msg.closing key}"
                  cryptsetup close ${key}

                  if [ $? == 0 ]; then
                      echo -e "${msg.closed key}"
                  else
                      di "Failed to close LUKS device ${key}"
                  fi
             done
          '';

    in { options.m4ch1n3.base.luks =
           { keys = lib.mkAttrsOfSubmoduleOption
               { default = {}; }
               { device = lib.mkStrOption {}; };

             devices = lib.mkAttrsOfSubmoduleOption
               { default = {}; }
               { device = lib.mkStrOption {};

                 key.name = lib.mkEnumFromAttrNamesOption {}
                   cfg.keys;

                 key.size = lib.mkIntOption {};
                 key.offset = lib.mkIntOption {};
               };
           };

         config =
           { boot.initrd.luks.devices = lib.mapAttrs
               (_: { name, device, key }:
                 { inherit name device;

                   keyFile = "/dev/mapper/${key.name}";
                   keyFileSize = key.size;
                   keyFileOffset = key.offset;

                   preOpenCommands =
                     ''
                        echo -en "${msg.opening name}"
                        ${openKey key.name name}
                     '';

                   postOpenCommands =
                     ''
                        echo -e "${msg.opened name}"
                        ${closeKey key.name}
                     '';
                 }
               ) cfg.devices;
           };
       };

  users = { ... }: {};
}
