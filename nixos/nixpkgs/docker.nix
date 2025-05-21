{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
}
