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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.27/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1a40502d3c9630282f639b960213e201f4dbbab38d5217f927aea5a4ef285ae4"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.27/grove-x86_64-apple-darwin.tar.gz"
      sha256 "ec6c124383d94e5627aa495e7fa8639f4541950aab56ecf464c14aabfe17af11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.27/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6cb46ed9837e403dc2152274cd11abb95f024d3f204367d366f0ecfb071037a1"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.27/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "909ade66654e8648627042cc20671e64c1062fdc004cf78e672d9a726b4f10c5"
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
