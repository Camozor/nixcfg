# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  user = "camille";
  computer = "boulot";
in {
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  boot.initrd.luks.devices."luks-41adbc34-9611-425a-8c6c-3b6916b4e9d6".keyFile =
    "/crypto_keyfile.bin";
  networking.hostName = "${computer}"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    displayManager.defaultSession = "none+i3";
    windowManager.i3.enable = true;
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;

  programs._1password.enable = true;

  programs.nix-ld.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    cargo
    i3lock
    i3blocks
    betterlockscreen
    pavucontrol
    feh
    jq
    argocd
    jetbrains.idea-ultimate
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
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
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

  home-manager.users.${user} = { pkgs, ... }: {
    home.stateVersion = "23.05";

    home.sessionVariables = { EDITOR = "nvim"; };

    home.packages = with pkgs; [
      brave
      htop
      neovim
      ripgrep
      fzf
      tmux
      nodejs_18
      yarn
      docker
      docker-compose
      kubectl
      k9s
      kubelogin
      openvpn
      kubernetes-helm
      kustomize
      nodePackages.zx
      openssl
      envsubst
      grafana-loki
      flameshot
      stern
      stylua
      tldr
      zathura
      bruno
      beekeeper-studio
    ];

    home.file.".config/i3" = {
      source = ./dotfiles/private_dot_config/i3;
      recursive = true;
    };

    home.file.".config/tmux" = {
      source = ./dotfiles/private_dot_config/tmux;
      recursive = true;
    };

    home.file.".config/k9s" = {
      source = ./dotfiles/private_dot_config/k9s;
      recursive = true;
    };

    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      yazi = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        initExtra = "source ~/.config/zsh/init.sh";
        oh-my-zsh = {
          enable = true;
          theme = "arrow";
          plugins = [ "git" "fzf" "z" "kubectl" "vi-mode" ];
        };
        shellAliases = {
          ls = "lsd";
          cat = "bat";
          y = "yazi";
          screenshot = "flameshot gui -d 2000";
        };
        shellGlobalAliases = {
          G = "| grep";
          L = "| less";
        };

        plugins = [{
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.7.0";
            sha256 = "149zh2rm59blr2q458a5irkfh82y3dwdich60s9670kl3cl5h2m1";
          };
        }];
      };
    };
  };
}
