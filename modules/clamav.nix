{ pkgs, ... }:

{
  services.clamav = {
    daemon.enable = true;
    daemon.settings = {
      TCPSocket = "3310";
      TCPAddr = "127.0.0.1";
    };

    fangfrisch.enable = true;
    fangfrisch.interval = "daily";
    updater.enable = true;
    updater.interval = "daily"; # man systemd.time
    updater.frequency = 12;
  };

  environment.systemPackages = with pkgs; [ clamav ];
}
