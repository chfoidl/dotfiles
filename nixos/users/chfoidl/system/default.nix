{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chfoidl = {
    uid = 1803;
    group = "chfoidl";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    home = "/home/chfoidl";
    createHome = true;
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  users.groups = {
    chfoidl = {
      gid = 1803;
      members = [ "chfoidl" ];
    };
  };

  networking.extraHosts = ''
    127.0.0.1 www.test.pvmaker.local test.pvmaker.local e3dc.test.pvmaker.local www.pvmaker.local pvmaker.local e3dc.pvmaker.local
    127.0.0.1 www.test.solarmaker.local test.solarmaker.local company.solarmaker.local e3dc.test.solarmaker.local www.solarmaker.local solarmaker.local e3dc.solarmaker.local
  '';

}
