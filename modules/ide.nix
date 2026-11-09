{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    vim
    pkgs-unstable.vscode
  ];
}
