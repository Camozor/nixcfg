{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    gdb
    gnumake

    go
    air

    cargo
    rustc

    python3

    nixfmt-classic

    terraform
  ];
}
