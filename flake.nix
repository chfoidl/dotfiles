{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-hardware.url = "github:nixos/nixos-hardware/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.28.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper/v0.4.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ddev = {
      url = "github:wunderwerkio/nix-ddev/v1.22.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      overlays = with inputs;
        [ ];
      lib = import ./nixos/lib { inherit inputs overlays; };
    in
    {
      nixosConfigurations = {
        chf-workstation = lib.mkSystem {
          hostname = "chf-workstation";
          system = "x86_64-linux";
          users = [ "chfoidl" ];
        };
        tp-p14s = lib.mkSystem {
          hostname = "tp-p14s";
          system = "x86_64-linux";
          users = [ "chfoidl" ];
        };
      };
      homeConfigurations = {
        "chfoidl@chf-workstation" = lib.mkHome {
          username = "chfoidl";
          system = "x86_64-linux";
          hostname = "chf-workstation";
          stateVersion = "23.05";
        };
        "chfoidl@tp-p14s" = lib.mkHome {
          username = "chfoidl";
          system = "x86_64-linux";
          hostname = "tp-p14s";
          stateVersion = "23.05";
        };
      };
    };
}
