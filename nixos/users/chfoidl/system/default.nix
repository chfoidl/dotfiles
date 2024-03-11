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
  '';

}
