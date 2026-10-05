{
  description = "Dev environment flake facilitating machine hopping";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, ... }@inputs: {
    nixosConfigurations.remote-x86_64 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/remote/default.nix
        disko.nixosModules.disko
      ];
    };
  };
}