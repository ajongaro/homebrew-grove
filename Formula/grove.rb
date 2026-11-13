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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.54/grove-aarch64-apple-darwin.tar.gz"
      sha256 "47f0f0ba681038f8bb698148063350dbff31bb055da0e8531eb37f4c180e45d9"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.54/grove-x86_64-apple-darwin.tar.gz"
      sha256 "1b85459ec78d2e55d965d4a28a461b7c86c4234342a38cd760da522a96a04eac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.54/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fc361255a7486b586ab14da6b05bece99e444f75afc70be32e0c1011c56e8b41"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.54/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "649339a4e0234493a870301546f6e9ee7802e916c457c20597988c1ad64cde43"
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
