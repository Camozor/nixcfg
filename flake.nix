{
  description = "My NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-code.url =
      "github:nixos/nixpkgs/5e2a59a5b1a82f89f2c7e598302a9cacebb72a67";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, nixpkgs-code, home-manager, ... }: {
    nixosConfigurations.boulot = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";

      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        pkgs-code = import nixpkgs-code { inherit system; };
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
        ./modules/hyprland.nix
        ./modules/i18n.nix
        ./modules/nix.nix
        ./modules/ide.nix
        ./modules/keyboard.nix
        ./modules/lsp.nix
        ./modules/programming-languages.nix
        ./modules/sound.nix
        ./modules/terminal-utils.nix
        ./modules/security.nix
        ./modules/services.nix
        ./modules/user.nix
        ./modules/virtualisation.nix
        ./modules/work.nix
      ];
    };
  };
}
