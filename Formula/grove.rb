# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.5/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1f1834d131afa225897eeeefeb0541fb03ce3205b7065397ff4e8ab4dda061e9"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.5/grove-x86_64-apple-darwin.tar.gz"
      sha256 "630d12256422641dcb739382dd695f8b0e1a97ac84987699e18cdfa99b991948"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.5/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "321aec093d939aca0bfeb019bcdfa30124ca69104dd6bdb9d443eb60e35e79dd"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.5/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "91d59007e461b1baef45201b56da17f334f044db52dcd030579a295c34b22c53"
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
