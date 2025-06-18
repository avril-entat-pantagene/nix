{
  inputs,
  lib,
  config,
  outputs,
  ...
}:
{

  # Garbage collection
  boot.loader.systemd-boot.configurationLimit = 50;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

}
