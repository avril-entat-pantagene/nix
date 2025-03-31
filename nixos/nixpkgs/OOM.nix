{
  inputs,
  lib,
  config,
  outputs,
  ...
}:
{
  # OOM configuration:

  # Slice to limit CPU and memory hogs
  # DOCS https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html
  # DOCS https://discourse.nixos.org/t/nix-build-ate-my-ram/35752?u=yajo
  systemd.slices.anti-hungry.sliceConfig = {
    CPUAccounting = true;
    CPUQuota = "50%";
    MemoryAccounting = true; # Allow to control with systemd-cgtop
    MemoryHigh = "50%";
    MemoryMax = "75%";
  };

  systemd.services.nix-daemon.serviceConfig.Slice = "anti-hungry.slice";

  # Avoid freezing the system
  services.earlyoom = {
    enable = true;
    enableNotifications = true; # Dangerous for more than 1 hacker per PC
  };

  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableSystemSlice = true;
    enableUserSlices = true;
  };

}
