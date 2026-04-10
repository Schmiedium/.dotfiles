{ ... }: {
  home.file = {
    ".config/waybar/config".source = builtins.path { path = ../../../user/waybar/config; name = "source"; };
    ".config/waybar/style.css".source = builtins.path { path = ../../../user/waybar/style.css; name = "source"; };
    ".config/starship.toml".source = builtins.path { path = ../../../user/starship/starship.toml; name = "source"; };
    ".config/ghostty/config".source = builtins.path { path = ../../../user/ghostty/config; name = "source"; };
    ".config/niri/config.kdl".source = builtins.path { path = ../../../user/niri/config.kdl; name = "source"; };
    ".config/niri/idle_lock.sh".source = builtins.path { path = ../../../user/niri/idle_lock.sh; name = "source"; };
    ".config/fuzzel/fuzzel.ini".source = builtins.path { path = ../../../user/fuzzel/fuzzel.ini; name = "source"; };
    ".config/dunst/dunstrc".source = builtins.path { path = ../../../user/dunst/dunstsrc; name = "source"; };
  };
}
