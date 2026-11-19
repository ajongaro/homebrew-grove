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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.62/grove-aarch64-apple-darwin.tar.gz"
      sha256 "269e2a01befeae6d6c80ff0b448f35a55399d8187babad6aa99bfbc06c6f9947"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.62/grove-x86_64-apple-darwin.tar.gz"
      sha256 "7e805b75dd6df5cad24b92b894a80b15618dcfbbf5a322b4ac69ae501124ec2d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.62/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ccf24e4e383c66c19fb38a19e9cc7c68b707e03cd1e85ddf817ae86da540968a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.62/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bc1f999878b706f7e8952c26f5543a6be94920fecdf37906261ba0b56cddbf58"
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
