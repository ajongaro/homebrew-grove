# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  version "0.1.0"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.0/grove-aarch64-apple-darwin.tar.gz"
      sha256 "469bf7c13c558281fa0e779b073f482c33ef563b28cd462c40e9ebd404b49d90"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.0/grove-x86_64-apple-darwin.tar.gz"
      sha256 "65ce8fcbf11272d1d3cd0175a7f0f7b7f845ce766b398dfd60661524e9e6ddd3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.0/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6af3885164a16231a128cc78657963054da0694b556023d08a83281585e9df9c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.0/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "04a0055617907c7cde3c761d53023613824425dec3698ecb98c82021cc484e51"
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
