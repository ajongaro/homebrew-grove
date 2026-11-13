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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.49/grove-aarch64-apple-darwin.tar.gz"
      sha256 "8d250ea730e8b381ca7ab9d28334f0759119d7d099416a706e9c36e46261a52a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.49/grove-x86_64-apple-darwin.tar.gz"
      sha256 "db729686095464951bbbd086dafb273cfdebf305ab91bcf92061baf14178072b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.49/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "81f3275e181a1d87f533a9a0a36f9053536e0333b7757e6013f7ed16ffa127f4"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.49/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "da996043fbedfcdc1f072ec8043dbf99dd2d127456b0d88d323116522458af11"
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
