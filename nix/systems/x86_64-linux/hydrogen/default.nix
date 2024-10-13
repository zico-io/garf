{ config, lib, pkgs, ... }:

with lib;
with lib.garf;

{
  imports = [ ./hardware.nix ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  garf.system = {
    type = "minimal";
    hostName = "hydrogen";
    };
}
