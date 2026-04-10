{ inputs, ... }: {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      inputs.determinate.nixosModules.default
      { nixpkgs.overlays = [ inputs.claude-code.overlays.default ]; }
      (inputs.import-tree ./_nixos)
    ];
  };
}
