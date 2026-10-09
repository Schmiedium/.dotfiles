{ ... }: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "Alex Eisenschmied";
      user.email = "105024964+Schmiedium@users.noreply.github.com";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      core.editor = "nvim";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSigners = "~/.ssh/allowed_signers";
    };
  };
}
