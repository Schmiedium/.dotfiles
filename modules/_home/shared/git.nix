{ ... }: {
  programs.git = {
    enable = true;
    userName = "Alex Eisenschmied";
    userEmail = "105024964+Schmiedium@users.noreply.github.com";

    extraConfig = {
      core.editor = "nvim";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSigners = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
