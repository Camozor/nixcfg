{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ nerdfonts meslo-lgs-nf ];
  environment.systemPackages = with pkgs; [ nerdfonts ];
}
