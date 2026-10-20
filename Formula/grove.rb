# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.10/grove-aarch64-apple-darwin.tar.gz"
      sha256 "fd63d2097591c7e9ef1cba766aa471794dce67e4d0485b9d89f31d9929c8ee33"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.10/grove-x86_64-apple-darwin.tar.gz"
      sha256 "c546c49c1a4c3dc57635b27ef9be2881ceb1ef4c40d52ae04b302a0357ce0b32"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.10/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "df1f0d7473a634773ab94cfef0aa8b1b3c344e22d6916854d108f07c1b1f1c9c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.10/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a66bd0ac48e20b566c796b5e266c5daf5970b842617fc8266ea99184209cb043"
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
