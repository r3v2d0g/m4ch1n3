.PHONY: build
build:
	nixos-rebuild --flake . build -L

.PHONY: switch
switch: build
	nixos-rebuild --flake . switch --use-remote-sudo

.PHONY: switch
test: build
	nixos-rebuild --flake . test --use-remote-sudo
