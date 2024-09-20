{ pkgs, ... }:

{
  services.dbus.enable = true;
  services.printing.enable = true;

  programs.thunar.enable = true;
  programs._1password.enable = true;
  programs.nix-ld.enable = true;
}
