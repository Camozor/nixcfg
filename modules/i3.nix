{ pkgs, ... }:

{
  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    windowManager.i3.enable = true;
  };
  services.displayManager.defaultSession = "none+i3";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  environment.systemPackages = with pkgs; [
    i3lock
    i3blocks
    betterlockscreen
    flameshot
    xclip
    dunst
  ];
}
