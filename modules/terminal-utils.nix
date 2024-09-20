{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ascii
    wget
    man-pages
    man-pages-posix
    lsd
    bat
    hostname-debian
    git
    unzip
    jq
    fd
    fzf
    ripgrep
    tmux
  ];
}
