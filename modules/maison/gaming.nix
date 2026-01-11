{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [ mangohud gamemode ];
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    steam-run
    heroic-unwrapped

    freetype
    fontconfig
    xorg.libXrender
    xorg.libXext

    wineWowPackages.waylandFull
    winetricks

    vulkan-tools
    pkgsi686Linux.vulkan-tools

    gamemode
  ];
}
