# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.9/grove-aarch64-apple-darwin.tar.gz"
      sha256 "5c4c288fac95585f5df7a3dbe9e24531a2949f0e3be227405acd64196d444490"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.9/grove-x86_64-apple-darwin.tar.gz"
      sha256 "2ede482b9028e18a70d44eea9ba727e7757932ddb226884f7e1227c81d46e828"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.9/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "87af0cb878c34d404ba5b517e5d6aa1cdecceac8d846eb03081844baf46fff8c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.9/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bb5d245c37e3cc4cd23f4982e17c40feadc9b002e68a60ee3901034f2252ac04"
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
