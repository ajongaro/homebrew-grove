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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.30/grove-aarch64-apple-darwin.tar.gz"
      sha256 "4e03a671add9f206f5d12210bfe831e60a546618663128010d8daecfbf69e682"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.30/grove-x86_64-apple-darwin.tar.gz"
      sha256 "0ad2a6fa77d02bce5448241e159b3c54affc056678c8fce33beb642d46f5695f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.30/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0b18db098274619edc44ae7cea199d4a011e29a8485bf1f6a32d5ff828597b46"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.30/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ad038331187f3bfebebf47a0e113b59733f889f5943104ac89c434779bcd58e6"
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
