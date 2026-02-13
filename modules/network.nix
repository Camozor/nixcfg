{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    networkmanager-openvpn
  ];

  networking.networkmanager = {
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  # Enable networking
  networking.networkmanager.enable = true;
}
