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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.32/grove-aarch64-apple-darwin.tar.gz"
      sha256 "5f09870ac676a448972831dc7f23b6f1230039b0d40d98a24ea6ef2daebc68f4"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.32/grove-x86_64-apple-darwin.tar.gz"
      sha256 "eb203d4f8d86f856a8ca2446c2a472171977881391992d80df04dfecb649b9e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.32/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "22edeb8f29e7be22fb1fba7884865372de016481b408371dc6ce6531c43bac72"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.32/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6e0471105dbde1e78a7fabe34a06c7442f531489bd72b2408f2ceb7d1d9bf085"
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
