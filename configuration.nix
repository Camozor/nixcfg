# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:
let user = "camille";
in {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.extraHosts = ''
    127.0.0.1 localhost
    127.0.0.1 esg
    127.0.0.1 neomi
  '';

  services.dbus.enable = true;

  programs.thunar.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  programs.zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;

  programs._1password.enable = true;

  programs.nix-ld.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty
    gcc
    go
    air
    cargo
    rustc
    argocd
    gdb
    discord
    firefox
    gnumake
    nixfmt-classic
    terraform
    azure-cli
    libreoffice
    teams-for-linux
    virt-manager
    qemu
    python3
    brave
  ];

  documentation.dev.enable = true;

  networking.enableIPv6 = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
