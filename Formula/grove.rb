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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.29/grove-aarch64-apple-darwin.tar.gz"
      sha256 "37eb8576efa69bf00c4a44c2156d1d95eb7507f6d35df924eab9dbc6364bba4a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.29/grove-x86_64-apple-darwin.tar.gz"
      sha256 "a299526dc2e7d5e35246f6dafc0f9d51007353ab54cf47b0bd60f4d5d072d394"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.29/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "121d519ce5a7dc7436b4e5efa1d9838b0439cced8a42076879da57d7e8bebea0"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.29/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "92a480812310cd5bc3cb8ce195c2c6f70655e1cc9535db4e669a478bd2c1a8a7"
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
