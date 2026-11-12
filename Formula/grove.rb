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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.41/grove-aarch64-apple-darwin.tar.gz"
      sha256 "8bca6722eda50321c8a655d94cd8772abe2ea3e4129d0ce39cdc9da068c84d06"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.41/grove-x86_64-apple-darwin.tar.gz"
      sha256 "6002c749b4858cb6b5f08128446eb85de1f84dc4631bc32524d5f214e7de2525"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.41/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5015059d7a7e3d1c240c35a9a26d255f780748a101c8e1d9706eaa232c931ff3"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.41/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "87a541a17ba8a2a0b43f8f448cb018d83aa8c7ad4c0d66eb5f44ec5099a3d798"
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
