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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.45/grove-aarch64-apple-darwin.tar.gz"
      sha256 "7d595513e34f6da5f9bf6106ffaacb15e0657de2611284125b1f96ee8a3be53e"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.45/grove-x86_64-apple-darwin.tar.gz"
      sha256 "44972501fbbc4bb8b420faeb3b162402e9c30a23b584cee6e9aacc76a5cb452e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.45/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c18e7915155cdc6c0d58eeba03de9b25625713805f5ba159553cb76a7b441856"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.45/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "045c75b376d32e7417728e0464e04b9528f82edd0fa750f95f650c8d25710471"
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
