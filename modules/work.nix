{ pkgs, ... }:

{
  networking.extraHosts = ''
    127.0.0.1 localhost
    127.0.0.1 esg
    127.0.0.1 neomi
  '';

  environment.systemPackages = with pkgs; [ discord teams-for-linux ];
}
