{ ... }:

{
  services.dbus.enable = true;
  services.printing.enable = true;

  services.kanata = {
    enable = true;
    keyboards = {
      laptop = {
        configFile = ../home/kanata/kanata.kbd;
        devices = [ ];
      };
    };
  };

  programs.thunar.enable = true;
  programs._1password.enable = true;
  programs.nix-ld.enable = true;

}
