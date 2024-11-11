{ pkgs, ... }:

{
  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  environment.systemPackages = with pkgs; [ nerdfonts ];
}
