update:
		nix flake update

maison:
		sudo nixos-rebuild switch --flake .#maison

boulot:
		sudo nixos-rebuild switch --flake .#boulot

garbage:
		sudo nix-collect-garbage -d --delete-older-than 5d

fmt:
		nixfmt .
