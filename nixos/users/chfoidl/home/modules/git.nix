{ ... }:
{
  sops.secrets."git-config" = {
    path = "/home/chfoidl/.config/git/custom-config";
  };

  programs.git = {
    enable = true;
    includes = [
      { path = "~/.config/git/custom-config"; }
    ];
  };
}

