{ pkgs, ... }:

{
  sound = {
    enable = true; # Enable sound with pipewire.
    mediaKeys.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
    pulseaudio
    vlc
    spotify
  ];
}
