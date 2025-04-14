{ pkgs, ... }:

{
  networking.extraHosts = ''
    127.0.0.1 localhost
    127.0.0.1 kamineo
    127.0.0.1 neomi
  '';
  networking.enableIPv6 = false;

  environment.systemPackages = with pkgs; [ teams-for-linux azure-cli ];
}
