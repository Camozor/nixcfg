{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.libinput.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "fr";
  };
  services.displayManager.sddm = {
    enable = true; # Crucial base service activation
    wayland.enable = true;
    settings = { Input = { KeyboardLayout = "fr"; }; };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpaper
    hyprmon
    awww
    xdg-desktop-portal-gtk
    wayland-utils
    wl-clipboard
    rofi
    wofi
    waybar
    dunst
    libnotify
    grim
    slurp
    (flameshot.override { enableWlrSupport = true; })
    palenight-theme
  ];
}
