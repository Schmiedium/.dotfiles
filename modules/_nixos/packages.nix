{ pkgs, ... }: {
  # Creative, GUI, and proprietary apps — desktop machine only
  environment.systemPackages = with pkgs; [
    gcc
    gimp
    freecad
    openscad
    blender
    obsidian
    zotero
    unityhub
    discord
    claude-code
  ];
}
