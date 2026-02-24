{
  config,
  pkgs,
  lib,
  ...
}:
with pkgs;
let
  patchDesktop =
    pkg: appName: from: to:
    lib.hiPrio (
      pkgs.runCommand "$patched-desktop-entry-for-${appName}" { } ''
        ${coreutils}/bin/mkdir -p $out/share/applications
        ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      ''
    );
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in
{

  # GPU fix
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
  };
  hardware.graphics.enable = true; # Enables graphics support

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:4:0:0";
  };

  # App launch fix
  environment.systemPackages = with pkgs; [
    (GPUOffloadApp steam "steam")
  ];
}

/*
// GISTRE - mettre ça à la place de ma config si j'ai des bugs...
{
  boot = {
    blacklistedKernelModules = [
      "nouveau"
      "nova_core"
    ];
    kernelModules = [
      "nvidia"
      "nvidia_drm"
    ];
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      dynamicBoost.enable = true;
      modesetting.enable = true;
      open = true;
    };
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];
}
*/
