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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.50/grove-aarch64-apple-darwin.tar.gz"
      sha256 "34f5ee3abdac83a35140898d194faaa277b4185d3fa35b6504776b5db7d93260"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.50/grove-x86_64-apple-darwin.tar.gz"
      sha256 "dfb3c97c289238ce339c8e04c652422e8e4548519a68254a6cf4f69602f921b6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.50/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0b9fbceac649ef878d6407c5d9bfd50fa2dddd3aa6937db38da7f4ed75e0a1e3"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.50/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "feae2656c5189f0f460d5707d19906c756fe36d7279e041f705bfde59c4676ee"
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
