{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    vim
    vscode
    jetbrains.idea-ultimate
  ];
}
