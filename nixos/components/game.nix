{ pkgs-unstable, ... }:
{

  programs = {
    steam = {
      enable = true;
      protontricks.enable = true;
    };
  };

  users.users.avril.packages = with pkgs-unstable; [
    heroic
    prismlauncher

    # retroarch
    (retroarch.withCores (
      cores: with cores; [
        atari800
      ]
    ))
  ];

}
