# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.15/grove-aarch64-apple-darwin.tar.gz"
      sha256 "42bce328dd273863acef2c5107b258f846f203e78c45799b9258861e5fdf6837"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.15/grove-x86_64-apple-darwin.tar.gz"
      sha256 "83021da280d226fe4a83b571c6d25b49527bc94d99c95364ef484185a54da539"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.15/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "66232564a5ef282959549352b520b8b661278bc71678aefa61b069b87b909f5c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.15/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5fc62f5bbd93c6ae4aa7472f0c84e473205291407dc945931246605bd5bf54f4"
    end
  end

  def install
    bin.install "grove"
  end

  def caveats
    <<~EOS
      Grove needs Claude Code, logged in: https://code.claude.com/docs
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
