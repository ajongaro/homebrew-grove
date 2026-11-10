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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.35/grove-aarch64-apple-darwin.tar.gz"
      sha256 "0c7b7dd8f59926b006fe2f3a38da026f41304d0755ba57bd6734637f318d0bb4"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.35/grove-x86_64-apple-darwin.tar.gz"
      sha256 "a44c3e28a97c15df23419e510022d04047ab0b05c4b54deff25cd12790c51eb0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.35/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "16c84bcf0f7eb071b3e7149352d6a4ec1dcad1d0fe6ff05fadcb1a4723b03dd9"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.35/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a189bfe7fd33a85276a24af599fc4c879d57762cd17022b56f9ee4e3c9566b57"
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
