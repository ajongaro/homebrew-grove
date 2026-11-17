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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.61/grove-aarch64-apple-darwin.tar.gz"
      sha256 "3d2d2baee76d7398daac167f667e8136eb80bc21a3a21bacf05e300cf235c318"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.61/grove-x86_64-apple-darwin.tar.gz"
      sha256 "c30c6d86c78ac9b49ab18de193ac413eb20bf71f5b7bbf966a63bb5111dd2aa0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.61/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "39223068aef8cd8f4ab58700f0bb68f109ab9e0d783becc0d5a69de33c9983db"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.61/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7d3a88174dd765b92c9dba03186fdccc2ee915acb12d1cc401706b7131897947"
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
