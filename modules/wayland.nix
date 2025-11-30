{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "gnome" ];
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [ mangohud gamemode ];
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    steam-run
    heroic-unwrapped

    freetype
    fontconfig
    xorg.libXrender
    xorg.libXext

    wineWowPackages.waylandFull
    winetricks

    vulkan-tools
    pkgsi686Linux.vulkan-tools

    gamemode
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ vulkan-loader ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ vulkan-loader ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
  };

}
