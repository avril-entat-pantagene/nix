{
  pkgs,
  inputs,
  lib,
  config,
  outputs,
  ...
}: {
  
  nixpkgs.config.packageOverrides = pkgs: rec { plytheme = pkgs.callPackage ./plymouth/PlyTheme.nix {}; };
  environment.systemPackages = with pkgs; [ plytheme ];

  # Bootloader
  boot = {
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

    initrd.systemd.enable = true; # Enables systemd services in the initial ramdisk (initrd)
    plymouth = {
      enable = true;
      theme = "vinyl";
      themePackages = [ pkgs.plytheme ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
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

}

