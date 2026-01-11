{
  description = "My NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-code.url =
      "github:nixos/nixpkgs/5e2a59a5b1a82f89f2c7e598302a9cacebb72a67";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, nixpkgs-code, home-manager, ... }:
    let
      system = "x86_64-linux";
      common-modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.camille = import ./modules/home.nix;
        }

        ./modules/bootloader.nix
        ./modules/fonts.nix
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
      ];
    in {
      nixosConfigurations = {
        "maison" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
            pkgs-code = import nixpkgs-code { inherit system; };
          };

          modules = common-modules ++ [
            ./modules/maison/hardware-configuration.nix
            ./modules/maison/gaming.nix
            ./modules/maison/gnome-wayland.nix
            { networking.hostName = "maison"; }
          ];
        };

        "boulot" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
            pkgs-code = import nixpkgs-code { inherit system; };
          };

          modules = common-modules ++ [
            ./modules/boulot/hardware-configuration.nix
            ./modules/boulot/encryption.nix
            ./modules/boulot/hyprland.nix
            ./modules/boulot/work.nix
            { networking.hostName = "boulot"; }
          ];
        };
      };
    };
}
