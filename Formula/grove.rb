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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.67/grove-aarch64-apple-darwin.tar.gz"
      sha256 "0f61b9cf9fb94ef4ae5c4c06556ef4570f2ef1df4bb2ecbed15864624ddc672c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.67/grove-x86_64-apple-darwin.tar.gz"
      sha256 "5789d103ecce80b17f23e6e0c2a1a6d776e6fdaefe9df4b97e5d304b5e3e4c90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.67/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5550ec9205c03e5782f3bc28fc30a1c7cee15370fb7262fb8b07695cbc0bda27"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.67/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "86a2623f8e492df7e581b159d22bbc1e32f8adbd9d357ac2410dce15ec905e68"
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
