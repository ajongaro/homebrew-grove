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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.38/grove-aarch64-apple-darwin.tar.gz"
      sha256 "6044f19b0d2154ae815008e7e0e73bbf1d8bc164b7cbf6231e834f2759490054"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.38/grove-x86_64-apple-darwin.tar.gz"
      sha256 "0aa61220fa160863ced7a783f5bcd8a5b81a37c3ab90e40ddb274c9d9aa2de9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.38/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7df880b7713cae39918c116869df568025cbfa48941469611bb9784482495e96"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.38/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b3c8d9d04cbbc1940c5f63ea7d53c071ea08ca3efa026def6bf569c150deafd2"
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
