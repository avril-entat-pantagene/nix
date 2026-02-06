{
  pkgs,
  lib,
  ...
}:
{
  services.xserver.enable = true; # optional
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.corefonts
      pkgs.vista-fonts
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };

  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    bibata-cursors
  ];

}
