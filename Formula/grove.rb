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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.33/grove-aarch64-apple-darwin.tar.gz"
      sha256 "7fc8bb82b982120ef5fff368efa65c9cd613cd8966979b9409a05a3d4fea891a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.33/grove-x86_64-apple-darwin.tar.gz"
      sha256 "81d82763ecadaf56ae4a8e9a778451a4cfb2c8dc44e26c9f552deea61eda8eb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.33/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "707d2f3534a7a4b66b968759ca14690a28550e27297f83293047ac330e95361b"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.33/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4d50029c8c2fa57d3959ea3c696d06b1b6d50e70572aca2dc862a07b56e63091"
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
