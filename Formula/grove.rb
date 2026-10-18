# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.2/grove-aarch64-apple-darwin.tar.gz"
      sha256 "6b6191822654915e75457369013dfff11fe050c248bd7ad92315a7418603c330"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.2/grove-x86_64-apple-darwin.tar.gz"
      sha256 "6d4c53a571c4219f4519512693029c0d2506a6445dd7b5292e7464dc58a0c236"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.2/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "52e516df645e7d88765f3e784466c208e9388c99d767f7fe8d39bad5cfadd16a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.2/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "de3cd44dcaad266caa2328efdeabfe2aa24c5a91c265913540b089555a37a070"
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
