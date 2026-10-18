# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.3/grove-aarch64-apple-darwin.tar.gz"
      sha256 "e0fa54d2fea12f48357dc7e66a82479e321807de8e2d1324976d7a05f36c6902"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.3/grove-x86_64-apple-darwin.tar.gz"
      sha256 "b92ebdc000b5ff04912224992cc4ab037804d9199d45ae2ea4aff9b252fedd4d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.3/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c79d9d96639348808c976b9241261f53771ae20327a56dc036a3a4913bad0cbb"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.3/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fbec845d088fbf92a4453fd5094b5574f81f5c6fd4facc396dfe401ba4a2bee0"
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
