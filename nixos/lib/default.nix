{ inputs, overlays }:
{
  mkSystem = { hostname, system, users ? [ ] }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs system hostname;
        unstablePkgs = builtins.getAttr system inputs.nixpkgs-unstable.outputs.legacyPackages;
      };
      modules = [
        ../systems/${hostname}
        {
          networking.hostName = hostname;

          # Allow unfree
          nixpkgs = {
            inherit overlays;
            config.allowUnfree = true;
          };

        }
      ] ++ inputs.nixpkgs.lib.forEach users (u: ../users/${u}/system);
    };

  mkHome = { username, system, hostname, stateVersion }:
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit system hostname inputs;
        unstablePkgs = builtins.getAttr system inputs.nixpkgs-unstable.outputs.legacyPackages;
      };
      pkgs = builtins.getAttr system inputs.nixpkgs.outputs.legacyPackages;
      modules = [
        inputs.sops-nix.homeManagerModules.sops
        ../users/${username}/home
        {
          nixpkgs = {
            inherit overlays;

            config = {
              allowUnfree = true;
              # Workaround for https://github.com/nix-community/home-manager/issues/2942
              allowUnfreePredicate = (_: true);
              permittedInsecurePackages = [
                "electron-24.8.6"
              ];
            };
          };

          programs = {
            home-manager.enable = true;
            git.enable = true;
          };

          home = {
            inherit username stateVersion;
            homeDirectory = "/home/${username}";
          };
        }
      ];
    };
}
