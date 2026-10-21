# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.12/grove-aarch64-apple-darwin.tar.gz"
      sha256 "3507f62be4361144aa0b7a7348d8e3160fa0d342a012bbaeec0f822c166e716b"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.12/grove-x86_64-apple-darwin.tar.gz"
      sha256 "10b5156585c525d41b1f1263c31e93fea0ade6e62d5a7c5a72ec5529bfa00bb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.12/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "38bac4dfef2aad4ff1420214c6e6b74af234d2af04a9aea13c14248ae0d37745"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.12/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "63eeb304e60b8651465b0a29b7a4f5a128e924e318cb84e60a6b180b1aa53272"
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
