{ pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    ascii
    htop
    bottom
    wget
    envsubst
    man-pages
    man-pages-posix
    lsd
    bat
    hostname-debian
    git
    unzip
    jq
    yq
    libxml2
    fd
    fzf
    ripgrep
    tldr
    tmux
    kanata
    curlie
  ];
}
