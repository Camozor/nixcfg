{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.boulot = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.camille = import ./home.nix;
        }

        ./modules/bootloader.nix
        ./modules/fonts.nix
        ./modules/hyprland.nix
        ./modules/i18n.nix
        ./modules/nix.nix
        ./modules/ide.nix
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
