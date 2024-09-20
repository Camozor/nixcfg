{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
