{ inputs, ... }: {
  flake.homeConfigurations.alex = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    modules = [ ../home.nix ];
  };
}
