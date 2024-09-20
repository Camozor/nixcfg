# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let user = "camille";
in {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  boot.initrd.luks.devices."luks-41adbc34-9611-425a-8c6c-3b6916b4e9d6".keyFile =
    "/crypto_keyfile.bin";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.extraHosts = ''
    127.0.0.1 localhost
    127.0.0.1 esg
    127.0.0.1 neomi
  '';

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver = {
    enable = true;
    xkb.layout = "fr";
  };

  services.displayManager.sddm.wayland.enable = true;

  services.displayManager.sddm.settings = {
    Input = { KeyboardLayout = "fr"; };
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.thunar.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  sound = {
    enable = true; # Enable sound with pipewire.
    mediaKeys.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
    man-pages
    man-pages-posix
    ascii
    wget
    vim
    nerdfonts
    hostname-debian
    lsd
    bat
    kitty
    git
    unzip
    gcc
    go
    air
    cargo
    rustc
    pavucontrol
    pamixer
    feh
    jq
    argocd
    jetbrains.idea-ultimate
    vscode
    gdb
    discord
    slack
    spotify
    firefox
    gnumake
    nixfmt
    pulseaudio
    terraform
    ffmpegthumbnailer
    unar
    poppler
    fd
    azure-cli
    libreoffice
    teams-for-linux
    virt-manager
    qemu
    python3
    vlc
    obsidian

    hyprland
    hyprlock
    hyprpaper
    swww
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    rofi-wayland
    wofi
    waybar
    dunst
    libnotify
    grim
    slurp
  ];

  fonts.packages = with pkgs; [ nerdfonts meslo-lgs-nf ];

  documentation.dev.enable = true;

  # List services that you want to enable:
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
  services.clamav.daemon.settings = {
    TCPSocket = 3310;
    LogTime = true;
    LogClean = true;
    LogSyslog = false;
    LogVerbose = true;
    DatabaseDirectory = "/var/lib/clamav";
    Foreground = true;
  };

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
