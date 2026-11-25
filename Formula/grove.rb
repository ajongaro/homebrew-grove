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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.68/grove-aarch64-apple-darwin.tar.gz"
      sha256 "4a01308403addf3e94c082da63f885c93ecba421aac84b6e3a94668346fb8dc8"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.68/grove-x86_64-apple-darwin.tar.gz"
      sha256 "63f4c400e32d70f3b6a96c18f71759572f68670bfe925e7dd2cd3ffcf698d0d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.68/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "754ea7c8ed36f7da201168a9da4409e9f0fc6fbbe877f0324efd4c50fc9647de"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.68/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c6b852c3d21e3094c17d28a9ba8e67cbd98e791be1384e1e0b3ad211a2d17b9f"
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
