{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    docker
    docker-compose

    kubectl
    k9s
    kubelogin
    stern
    kubernetes-helm
    kustomize

    virt-manager
    qemu
  ];
}
