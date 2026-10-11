{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # services.libinput.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "fr";
  };
  # The hyprland package ships both `hyprland.desktop` and `hyprland-uwsm.desktop`
  # in share/wayland-sessions, so SDDM lists both regardless of
  # `programs.hyprland.withUWSM`. The uwsm entry sorts first and would be picked
  # by default, but it fails instantly because uwsm's systemd user units are not
  # installed (programs.uwsm.enable = false). Pin the plain Hyprland session.
  services.displayManager.defaultSession = "hyprland";

  services.displayManager.sddm = {
    enable = true; # Crucial base service activation
    wayland.enable = true;
    settings = {
      Input = {
        KeyboardLayout = "fr";
      };
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };

  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpaper
    hyprmon
    awww
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
