{ pkgs, ... }:

{
  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
  environment.systemPackages = with pkgs; [ nerd-fonts.fira-code ];
}
