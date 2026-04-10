{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.lazy-trees = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    libgcc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];

  system.stateVersion = "25.05";
}
