{ pkgs, ... }:

{
  fonts.packages = with pkgs;
    [ (nerd-fonts.override { fonts = [ "FiraCode" ]; }) ];
  environment.systemPackages = with pkgs; [ nerd-fonts ];
}
