{
  description = "My NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }: {
    nixosConfigurations.boulot = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";

      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
      };

      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.camille = import ./modules/home.nix;
        }

        ./modules/bootloader.nix
        ./modules/fonts.nix
        ./modules/hardware-configuration.nix
        # ./modules/hyprland.nix
        ./modules/i3.nix
        ./modules/i18n.nix
        ./modules/nix.nix
        ./modules/ide.nix
        ./modules/keyboard.nix
        ./modules/lsp.nix
        ./modules/programming-languages.nix
        ./modules/sound.nix
        ./modules/terminal-utils.nix
        ./modules/services.nix
        ./modules/user.nix
        ./modules/virtualisation.nix
        ./modules/work.nix
      ];
    };
  };
}
