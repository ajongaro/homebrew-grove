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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.31/grove-aarch64-apple-darwin.tar.gz"
      sha256 "fb365cd583a235d1f5018db0c0e4a69fb2c13c4309bb16406e778ff01b183842"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.31/grove-x86_64-apple-darwin.tar.gz"
      sha256 "8c3ff2e865edd15559b5eb7fcd7467674e479c1caa9e18abe4abfa116ad63394"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.31/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4cd64e55a6baebc4599ae5d85e92ea3683e5e94d76f049b75565543a9dc4b95d"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.31/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7aba733846ea2bc3ab10d28593c12d539bb9c759e01de145cefa496e9b31f6f0"
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
