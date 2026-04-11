{ pkgs, ... }: {
  myConfig.useNoctalia = true;
  home.packages = [ pkgs.noctalia-shell ];
}
