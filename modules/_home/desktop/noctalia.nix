{ pkgs, ... }: {
  myConfig.useNoctalia = false;
  home.packages = [ pkgs.noctalia-shell ];
}
