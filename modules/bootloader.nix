{ ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  boot.initrd.luks.devices."luks-41adbc34-9611-425a-8c6c-3b6916b4e9d6".keyFile =
    "/crypto_keyfile.bin";
}
