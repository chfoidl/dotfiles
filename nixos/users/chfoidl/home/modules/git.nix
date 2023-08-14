{ ... }:
{
  sops.secrets."git/name" = {};
  sops.secrets."git/email" = {};

  programs.git = {
    enable = true;
    userName = "Christian Foidl";
    userEmail = "christian@wunderwerk.io";
  };
}

