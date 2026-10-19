# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.6/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1058b1622af94ec52a1e97a4bec80387ae7c03db784f10432eb00a52442093c6"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.6/grove-x86_64-apple-darwin.tar.gz"
      sha256 "05a9160cca5907273970af0fad4e852b6857ebb5ec7b3117a5a06a6f33d24f65"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.6/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c65056604babc0fb472781626be8732c25764ff785b5ff7f3be8cf1e60824e4c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.6/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e2c98d4c2510b84e96e711594ffdaf23c5d99738d550cf429115b37a4ab75971"
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
