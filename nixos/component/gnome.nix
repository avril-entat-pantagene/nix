{
  pkgs,
  lib,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    #desktopManager.cinnamon.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "fr";
      variant = "oss_nodeadkeys";
    };

  };

  users.users.avril.packages = with pkgs; [
    #Gnome
    gnome-tweaks

  ];

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

    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.vitals
  ];

}
