{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
  mkHome = modules: inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = modules ++ [{
      home.username = "alex";
      home.homeDirectory = "/home/alex";
    }];
  };
in {
  flake.homeConfigurations = {
    # Full desktop configuration
    alex = mkHome [
      (inputs.import-tree ./_home/shared)
      (inputs.import-tree ./_home/desktop)
    ];
    # CLI-only configuration for Docker
    alex-docker = mkHome [
      (inputs.import-tree ./_home/shared)
    ];
  };
}
