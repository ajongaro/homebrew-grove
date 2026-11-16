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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.56/grove-aarch64-apple-darwin.tar.gz"
      sha256 "d975987d9f2e7a9051ed353863c5aec7dd05204f8c4f4903fce3b0c83c251b8b"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.56/grove-x86_64-apple-darwin.tar.gz"
      sha256 "6fa4a2f2ba533bd1dc2badf2ddd0207391bb13c1d19cc00fe5efcb9e766133c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.56/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a48da75c9fcd61706881b91ebad938cc76c09adf4397b8d20e8a5a8feaee28ec"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.56/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ecd55881a5c4b2666e483055934cc8796588687257ebe02388049d09cd781762"
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
