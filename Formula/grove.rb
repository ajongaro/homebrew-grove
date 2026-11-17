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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.57/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1544cbc3af8eac0d830171f8a1e499bc1413f9532dd0953455bae78d550c5f69"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.57/grove-x86_64-apple-darwin.tar.gz"
      sha256 "2f3d8f7525e407d468cb1c39d32fb8a661eea67373ba7713a3c6c3d5889029a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.57/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "70800cd3f4dcc9fb3e3c5bfd52b90ad03f0944270ba7e786288ca5e6772a5f14"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.57/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c6333a9db993860b6880aa10cef02ef32bacda6cd122454dc3dd5032d9687d1a"
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
