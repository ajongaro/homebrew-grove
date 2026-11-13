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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.43/grove-aarch64-apple-darwin.tar.gz"
      sha256 "9ec72d127d3e2e11339a978fc1232a61e348e3f3897a6d5163a23b6bbb866d94"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.43/grove-x86_64-apple-darwin.tar.gz"
      sha256 "f7f6b5007a20a86061a49bf628c7f790c580d975a74ec7869760eb8fc811240f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.43/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "90a5e3ef95a14797d471d88fc6e99fc5ef48f8d21f4874844839aa4b7f5981fd"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.43/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "803e148812154d03275c507936f7eeefb63412e637c1fcfbc43ed2f6d2e5bab0"
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
