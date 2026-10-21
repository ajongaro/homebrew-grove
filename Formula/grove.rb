# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.11/grove-aarch64-apple-darwin.tar.gz"
      sha256 "b17975487912dbcc3f7b81a61f636377a210edd5f5720b26bbf4353d0d9154ef"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.11/grove-x86_64-apple-darwin.tar.gz"
      sha256 "3c40800808bf6c141f3538777137bab1ef7dc862c63b4c7c6f80323dbe6a8079"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.11/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "18ce6dab6faa7d78f3665e195289c8243cf2f7e3e16832d7eaa84bc5f438dcb3"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.11/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "91b29aafc4d67359dc10f39c817d5e39fa1227bbd8ee9113047e1b8493ca4e4f"
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
