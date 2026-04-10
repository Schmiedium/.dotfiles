{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.hasklug
    nerd-fonts.fira-code
  ];
}
