{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.starship = {
    enable = true;
    # Configuration écrite dans ~/.config/starship.toml
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      # package.disabled = true;
      username = {
        disabled = false;
        show_always = true;
        style_user = "white bold";
        format = "[$user]($style) ";
      };
      sudo = {
        disabled = false;
        symbol = "👑 ";
        style = "red";
        format = "[Master $symbol]($style)";
      };
      status = {
        disabled = false;
        pipestatus = false;
        symbol = "";
      };
      git_metrics = {
        disabled = false;
      };
      c = {
        format = "via [$symbol]($style)";
      };
    };
  };

}
