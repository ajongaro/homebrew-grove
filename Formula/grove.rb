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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.36/grove-aarch64-apple-darwin.tar.gz"
      sha256 "6f219a241c70f2375472dfade991a3f605db29cdf266a0772088209f67010ee3"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.36/grove-x86_64-apple-darwin.tar.gz"
      sha256 "828170402945a49323a88188b1af093d0169a1bd48d95c09bd106490bcb0063f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.36/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f038b6bf408c864267b1426892139db73b9f814dd6bd3a7dbee38177d97a2a79"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.36/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "875610ad6d1f73309e294a7dbe98772e6d16c46e63afd211087de288ff3a18e3"
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
