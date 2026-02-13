{ pkgs, ... }:

{
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
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    hyprland
    hyprlock
    hyprpaper
    hyprmon
    swww
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    rofi
    wofi
    waybar
    dunst
    libnotify
    grim
    slurp
    (flameshot.override { enableWlrSupport = true; })
    palenight-theme
    glib
  ];
}
