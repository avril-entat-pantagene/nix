{ pkgs, ... }:
{

  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Libvirtd
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    qemu = {
      swtpm.enable = true;
    };
  };
}
