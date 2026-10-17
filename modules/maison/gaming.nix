{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [ mangohud gamemode ];
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    steam-run
    heroic-unwrapped

    freetype
    fontconfig
    libxrender
    libxext

    wineWow64Packages.waylandFull
    winetricks

    vulkan-tools
    pkgsi686Linux.vulkan-tools
  ];

  programs.nix-ld.libraries = with pkgs; [
    gamemode
    libGL
    vulkan-loader
    libx11
  ];
}
