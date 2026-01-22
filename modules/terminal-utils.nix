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
    unzip
    jq
    yq
    libxml2
    fd
    fzf
    ripgrep
    tldr
    tmux-sessionizer
    kanata
    curlie
    bc
    playerctl
    git-lfs
    unixtools.netstat
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
