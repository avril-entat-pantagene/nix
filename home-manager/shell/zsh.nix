{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          tag = "25.03.19";
          sha256 = "o8IQszQ4/PLX1FlUvJpowR2Tev59N8lI20VymZ+Hp4w=";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "zoxide"
        "thefuck"
      ];
      extraConfig = ''
        setopt HIST_FIND_NO_DUPS

        autoload -Uz compinit
        compinit

        setopt autocd  # cd without writing 'cd'
        setopt globdots # show dotfiles in autocomplete list
      '';
    };

    enableCompletion = false; # Needs to be false for zsh-autocomplete to work properly
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];

    shellAliases = {
      "cd" = "z";

      update = "nix flake update && sudo nixos-rebuild boot --flake .#avril";
      nrsa = "sudo nixos-rebuild switch --flake .#avril";
      nrba = "sudo nixos-rebuild boot --flake .#avril";

      ls = "lsd -A --group-dirs first";
      "•" = "ls";
      tree = "lsd --tree";
      grep = "grep --color -n";

      gf = "git fetch";
      gs = "git status && pre-commit";
      lg = "lazygit";

      c = "code .";
    };

    initContent = builtins.readFile ./zshInitContent.sh;

  };

}
