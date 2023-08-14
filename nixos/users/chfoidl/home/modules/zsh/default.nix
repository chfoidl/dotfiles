{ ... }:
let
  zshrc = builtins.readFile ./zshrc;
  zshPrompt = builtins.readFile ./zsh-prompt;
  zshVimMode = builtins.readFile ./zsh-vim-mode;

  zshAdditions = zshPrompt + "\n" + zshVimMode;

  nvimCommand = "nix run github:chfoidl/nvim-flake --offline";
in
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      g = "lazygit";
      grep = "grep --color=auto";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      df = "df -h";
      free = "free -m";
      psmem = "ps auxf | sort -nr -k 4 | head -5";
      pscpu = "ps auxf | sort -nr -k 3 | head -5";
      ls = "ls --color=auto";
      vim = "nvim";
    };
    enableCompletion = true;
    history = {
      size = 1000000;
      save = 1000000;
    };
    initExtraFirst = zshrc;
    initExtra = zshAdditions;
  };
}
