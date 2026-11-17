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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.58/grove-aarch64-apple-darwin.tar.gz"
      sha256 "642ae8c69bd7a3e8f79765beb9ec551bf9144adcda1998c905d381fae483d9bc"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.58/grove-x86_64-apple-darwin.tar.gz"
      sha256 "b651759fab4796062673ab10e4cc4f5761b04781f9be040b7da504b60fd5aebd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.58/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4bc1b347d4d2e97677f20830111ebf098b2656956b283604378ab5c71d12282a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.58/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e3f2936af7ab568bfa48a5ab1bef7e3a9ad3c7620542ae86676936605728319f"
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
