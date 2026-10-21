# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.13/grove-aarch64-apple-darwin.tar.gz"
      sha256 "d370fa8a61989e567b018b252b7d4e99f43aef2f78742fb3abb691231ea606b8"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.13/grove-x86_64-apple-darwin.tar.gz"
      sha256 "d5eb81da1120bb684035ca0b706aa2acee55707d7490c14c335c27cf557e60e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.13/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e5663dc139a6677c56078fa89687cf72cc7dad7610676f733d3c27b96bc69178"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.13/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fd418169f36a70ddd54b1f043b8c5e809cce5f36f957b80af87ed49999cb6713"
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
