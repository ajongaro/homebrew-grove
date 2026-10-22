# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.16/grove-aarch64-apple-darwin.tar.gz"
      sha256 "3b43b9260f77fcf8c83d15a6bcf387b1100d37b08d1a27129deb6c067bbe3e2a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.16/grove-x86_64-apple-darwin.tar.gz"
      sha256 "76db1d0ae50455280057ae5fa6b6b4d772f748f2a870190da5cac15b5da5aaf8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.16/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4025cb605c5fea74e1bbe6d5cbcac9dd2116b9dc07b2e98cfbc194de0cad70f5"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.16/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "28f30fde75d17a701910607ac42becd87c3b3b0edc3b8a8dc081e7b9ca9b3668"
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
