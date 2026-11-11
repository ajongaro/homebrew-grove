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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.37/grove-aarch64-apple-darwin.tar.gz"
      sha256 "d2897c56a00540a1e1683b1e7033a224eaf109d370c6d09031d8ff7dea7aab36"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.37/grove-x86_64-apple-darwin.tar.gz"
      sha256 "89ef732ca3a461344eccafe41c7791f31ddce4f86b37e39f2ed3a387f364d0ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.37/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "be38d756b3a540c60ec0f248c9af44d32c40bbae6accd1d45fcef273486f1bd1"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.37/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a0f5d34c02cff30369824363ccce816de1f9006992e114d6aa19fc14e024b806"
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
