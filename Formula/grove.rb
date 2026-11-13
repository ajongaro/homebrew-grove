# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  # On Linux, the system's tmux: a second one from Homebrew means whichever
  # a shell finds first starts Grove's server, and an older one can't reach
  # a server a newer one started.
  on_macos do
    depends_on "tmux"

    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.42/grove-aarch64-apple-darwin.tar.gz"
      sha256 "8ede0293f95ea616e055a236ff6529dd8e8eb0cfcc4b585be44cece3b573da72"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.42/grove-x86_64-apple-darwin.tar.gz"
      sha256 "5a5e110bf327d293eda09aa2a108b02bb3bfd3f34e8826b215703d02f0477aa3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.42/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7de94a0d902249077d6711a37ae396452ff40128de10bbe25f77ab92212eea7d"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.42/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6d86ea5d9b8076ff6c3421068a23d571c252b03949479d06d34a5262c7ec3bc7"
    end
  end

  def install
    bin.install "grove"
  end

  def caveats
    <<~EOS
      Grove needs Claude Code, logged in: https://code.claude.com/docs
      On Linux it uses your system's tmux (3.2 or newer): sudo apt install tmux
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
