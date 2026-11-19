# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  # On Linux, the system's tmux: a second one from Homebrew means whichever
  # a shell finds first starts Grove's server, and an older one can't reach
  # a server a newer one started.
  on_macos do
    depends_on "tmux"

    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.63/grove-aarch64-apple-darwin.tar.gz"
      sha256 "77cecfeb0cce5a96f2e72d1099c612d74efc2dad0ba64c74cb5821c3e7444065"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.63/grove-x86_64-apple-darwin.tar.gz"
      sha256 "e896e63111277adf042b8b138b7be9da09085e29120e099f2eb7fef93c27f4b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.63/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d6175642a7d707bacc5653a07422da17c4a3c74ab42de3de05071017dbb8f6a0"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.63/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "30c08761271a458a76b662f2fffe95986416937e91f75e102e598689121b4b2c"
    end
  end

  def install
    bin.install "grove"
  end

  def caveats
    <<~EOS
      Grove needs Claude Code, logged in: https://code.claude.com/docs
      On Linux it uses your system's tmux (3.2 or newer): sudo apt install tmux
      Check your setup with: grove doctor
      After brew upgrade grove, press R on the dashboard to restart it.
    EOS
  end

  test do
    assert_match "grove #{version}", shell_output("#{bin}/grove --version")
    ENV["GROVE_HOME"] = testpath/"grove"
    system bin/"grove", "add", testpath
    assert_path_exists testpath/"grove/projects"
  end
end
