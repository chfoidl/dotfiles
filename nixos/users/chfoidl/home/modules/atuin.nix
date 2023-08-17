{ ... }:
{
  xdg.configFile = {
    "atuin/config.toml".text = ''
      sync_address = "http://10.150.10.56:8888"
    '';
  };
}
