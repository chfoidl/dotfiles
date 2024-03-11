{ ... }:
{
  sops.secrets."git-config" = {
    path = "/home/chfoidl/.config/git/config";
  };

  programs.git = {
    enable = true;
  };
}

