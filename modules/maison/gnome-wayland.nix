{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    videoDrivers = [ "nvidia" ];
    autoRepeatDelay = 150;
    autoRepeatInterval = 20;
  };

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = [ "gnome" ];
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

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

  environment.systemPackages = with pkgs; [
    wl-clipboard
    (flameshot.override { enableWlrSupport = true; })
    qbittorrent-enhanced
  ];

  networking.firewall.enable = false;
}
