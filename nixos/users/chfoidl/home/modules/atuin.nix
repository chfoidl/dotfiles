{ ... }:
{
  sops.secrets."atuin/configFile" = {
    path = "/home/chfoidl/.config/atuin/config.toml";
  };
}
