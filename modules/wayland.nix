{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "nvidia" ];
  };

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

}
