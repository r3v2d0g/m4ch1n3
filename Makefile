.PHONY: build
build:
	nixos-rebuild --flake . build -L

.PHONY: switch
switch:
	nixos-rebuild --flake . switch --use-remote-sudo
