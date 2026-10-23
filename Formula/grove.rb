# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.18/grove-aarch64-apple-darwin.tar.gz"
      sha256 "6cdb8bad90573770ee862c79f5f9b6545df23a5bee5fce64f0560e6b411e6ae7"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.18/grove-x86_64-apple-darwin.tar.gz"
      sha256 "e7831efabee299bc20cadb1e47f453c5b410993f986585b5df07d38ab5aeb47f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.18/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2ee240bfbb16419eb205eef28e82dfd33cef9391e579da53e3bfd46e3aa68862"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.18/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1ffc1a034f1da93f22e93cc5577f7953f88d0a65f883cfc2ac8eeb62ce98a55d"
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
