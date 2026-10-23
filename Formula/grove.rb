# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.20/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1a9d12c874ea739bd8b9dfc50b6202300ac4f5d7d79d7a6a835065c2ed93c3f8"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.20/grove-x86_64-apple-darwin.tar.gz"
      sha256 "17fd07e6fe262b0fa70347b0abc3f599de5acd3d3b79b439b2b4f4e8a459ea19"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.20/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7fac3c3224012d4bffebab77c45214a730a8bfdee45f64081ac92d5bf865610a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.20/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ee8252062dc408fd01ca9158ad8b01aa58eca94464a0d8a7f6983cb08346f234"
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
