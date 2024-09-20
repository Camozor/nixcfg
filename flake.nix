{
  description = "A simple NixOS flake";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.boulot = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hardware-configuration.nix ./configuration.nix ];
    };
  };
}
