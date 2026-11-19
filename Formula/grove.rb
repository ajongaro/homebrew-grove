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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.64/grove-aarch64-apple-darwin.tar.gz"
      sha256 "21f57468956653410d6d447a0714a2d53df24c032b08145f4947bcfa0cee1030"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.64/grove-x86_64-apple-darwin.tar.gz"
      sha256 "272e5b828d6d1c883946501e32fd21c11e34daf94ec9427430a1eaba117879f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.64/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b6fd5a0dc4cabf7f66f38be5596693899daef022a8f2f70b31eec6753868829e"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.64/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f73efe2160108bdabb1e48032557573886b74271393ea8bbc65ab4d25579c71d"
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
