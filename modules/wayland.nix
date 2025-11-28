{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "fr";
  };
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = [ "gnome" ];
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [ mangohud gamemode ];
  };

  programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];

  environment.systemPackages = with pkgs; [ steam-run ];
}
