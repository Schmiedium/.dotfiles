{ pkgs, lib, ... }: {
  # CLI tools — shared between the desktop machine and Docker
  home.packages = with pkgs; [
    neovim
    nushell
    gitui
    lazygit
    nixpkgs-fmt
    nixd
    bacon
    yazi
    hyperfine
    dust
    ncspot
    jujutsu
    uv
    lua
    gnumake42
    nodejs_22
    stylua
    lua51Packages.luarocks
    ripgrep
    starship
    rustup
    clang
    (lib.lowPrio gcc)
    unzip
    wget
  ];
}
