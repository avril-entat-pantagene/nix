{ pkgs, lib, ... }:
{

  services.udev.packages = [ pkgs.usb-blaster-udev-rules ];

  environment.systemPackages = with pkgs; [
    # Serial
    pkgs.screen

    # Embedded
    arduino
    arduino-cli
    arduino-ide
    saleae-logic-2

    # Elec
    kicad
  ];

  # IOT
  services = {
    node-red = {
      enable = true;
      openFirewall = true;
      withNpmAndGcc = true;
    };
    mosquitto.enable = true;
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
