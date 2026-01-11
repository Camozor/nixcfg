{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [ pkgs-unstable.neovim vim vscode ];
}
