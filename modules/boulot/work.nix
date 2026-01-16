{ pkgs, ... }:

{
  networking.extraHosts = ''
    127.0.0.1 localhost
    127.0.0.1 kamineo
    127.0.0.1 neomi
  '';
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = "0";

  environment.systemPackages = [ pkgs.teams-for-linux pkgs.azure-cli ];
}
