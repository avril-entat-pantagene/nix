{
  pkgs,
  inputs,
  lib,
  config,
  outputs,
  ...
}:
{

  nixpkgs.config.packageOverrides = pkgs: rec {
    plytheme = pkgs.callPackage ./plymouth/PlyTheme.nix { };
  };

  environment.systemPackages = with pkgs; [
    plytheme
  ];

  # Bootloader
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    tmp.cleanOnBoot = true; # Clear /tmp during boot

    initrd = {
      verbose = false;
      systemd.enable = true; # Enables systemd services in the initial ramdisk (initrd)
    };

    plymouth = {
      enable = true;
      theme = "plymouthsmoothbrainkitty";
      themePackages = [ pkgs.plytheme ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    kernelParams = [
      "plymouth.use-simpledrm" # fix for this pc !
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_level=3"
      "udev.log_priority=3"
      "fbcon=nodefer" # no asus logo ?
    ];

  };

  systemd.services.NetworkManager-wait-online.enable = false;

}
