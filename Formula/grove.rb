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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.52/grove-aarch64-apple-darwin.tar.gz"
      sha256 "0c4823aae2f275f4579a885da2829effcc6d38f9146d1213baa867c0950e6444"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.52/grove-x86_64-apple-darwin.tar.gz"
      sha256 "d4398989c1bb28148d3eaa63aa5e497dc75ea7b6d52190b8024d50c74c12ceee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.52/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c4d8ba0fbe2d54c0560b1f05692ca0b7e330a7c13cab142d2fdc39d675a0879e"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.52/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "80e9da1a7910199492365bb0928d339b762294801ea06c5f295fbee607949e73"
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
