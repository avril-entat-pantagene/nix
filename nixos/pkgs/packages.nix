{
  pkgs,
  lib,
  ...
}:
{
  users.users.avril.packages = with pkgs; [

    home-manager

    vesktop
    vlc

  ];

}
