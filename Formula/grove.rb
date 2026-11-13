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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.46/grove-aarch64-apple-darwin.tar.gz"
      sha256 "a9a9771a85ebd28977e38276ffe15850e820e966dd175fb686b2ad1779e3f3ba"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.46/grove-x86_64-apple-darwin.tar.gz"
      sha256 "90d3299775bb99beb9541c9344df4ce46314f4e44259028cbad75bab5785eb78"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.46/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1618d808a3bcef236897e25af5e2ade179f6290ea7044b5aaa67e09d19c51859"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.46/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "124fa2eacb6e88d94fee7b9be45e890ed8d9177597aa46a2b881d8832ea28b24"
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
