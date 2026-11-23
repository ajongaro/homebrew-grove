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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.65/grove-aarch64-apple-darwin.tar.gz"
      sha256 "e59c363e2ff3964a79e934051f35c5eddd4db99da198242e1d5444b3d084ee09"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.65/grove-x86_64-apple-darwin.tar.gz"
      sha256 "6e530de45d6a65668835b4e54edf0d4dd6f98c5bb74394f87802ec4c76a5e35e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.65/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "518244704c4e1223cf7aef49138042504e2560c52339f1b3989bb164211c7fe6"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.65/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7f2948c1324c061271bd613280a53fc6c62f2a521ba037f5eff2c2d35db500e3"
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
