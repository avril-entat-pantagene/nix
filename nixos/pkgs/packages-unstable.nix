{ pkgs-unstable, lib, ... }:
{

  users.users.avril.packages = with pkgs-unstable; [
    gitlab-ci-local
  ];

}
