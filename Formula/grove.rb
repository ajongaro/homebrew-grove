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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.44/grove-aarch64-apple-darwin.tar.gz"
      sha256 "13a511462ebef7d36d70c376bf623312fc984b8674ab703e6cdeffa8ad9e96c9"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.44/grove-x86_64-apple-darwin.tar.gz"
      sha256 "053b6d9e87c0a420a45aa37cd4629052c685cc93856f1cd42b8f2d69d709e7e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.44/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a46e253b1d30e08bb9989e1664cb30c84b262e043a9f51a9cecbb1bd1cb34a98"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.44/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9072a11c1b3d58f508bd7cd5eee625a09f46bc20a47b10eca947b0fc07689482"
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
