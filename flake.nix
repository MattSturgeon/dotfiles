{
  description = "Matt's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixvim.url = "github:pta2002/nixvim";
  };

  outputs = {
    nixpkgs,
    home-manager,
    hyprland,
    nixvim,
    ...
  }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.matt = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          nixvim.homeManagerModules.nixvim
          hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland.enable = true;
          }
        ];
      };
    };
}
