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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.60/grove-aarch64-apple-darwin.tar.gz"
      sha256 "322dd298d3cd010a1272c6e0dd76bb355fefd3b6f0aadcd89dd84b8e32a8a5a5"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.60/grove-x86_64-apple-darwin.tar.gz"
      sha256 "a3d971de7340cf1c07f68168ead0bc457e3d07fe82afa4d609463d212527045d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.60/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1d5205a29642a2cf9c656e1a717fd173edd5089a95fc5425057cb2657cf0708e"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.60/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6f42058049c5955a6e6249c03a06491c431c25e5ddef2b48ab867419db50a5df"
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
