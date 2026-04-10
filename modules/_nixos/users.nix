{ pkgs, ... }: {
  users.users.alex = {
    shell = pkgs.nushell;
    isNormalUser = true;
    description = "Alex Eisenschmied";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
  };

  # Required for nushell to appear in /etc/shells so it can be a login shell
  environment.shells = [ pkgs.nushell ];
  environment.systemPackages = [ pkgs.nushell ];
}
