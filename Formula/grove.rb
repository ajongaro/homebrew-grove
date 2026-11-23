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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.66/grove-aarch64-apple-darwin.tar.gz"
      sha256 "d734fe395982b89f4b51cb9e492ec60e5b9126391a693b6b0d18dd7dec79636f"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.66/grove-x86_64-apple-darwin.tar.gz"
      sha256 "fadb2cd26e08a7adb21ca4b00f74c7c11c8798d1040cb38426fa4191453ecb6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.66/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "702943110c25f5ef6f9190d72f3d25df06fd462b2c17f7a440c80468e46f6ba4"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.66/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "763ebec894484b3e1490334e931040095bda48b17536bdfe6dfd0afd40873ad1"
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
