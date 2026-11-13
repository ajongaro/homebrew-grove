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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.51/grove-aarch64-apple-darwin.tar.gz"
      sha256 "d0d2f2f6daa55c5f7c7636a9bf36961b706a9af146eda6166175f699512fe880"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.51/grove-x86_64-apple-darwin.tar.gz"
      sha256 "935bc109a9ff0d7aae6a4e24b0f4b3733a7a6edae3f4cfbff76929adab97ae59"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.51/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ac94430debaacb0b0bc371deb16fd62f30d61ff3659a31216006c6e5108f8d35"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.51/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2c3f871d96732b6c8786661d243dedc8742c19b176af99e2784dc0f2b767dd5b"
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
