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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.34/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1167bbef67416077910704b8c53830a9f787fbe94e2ab2e63474f68b06f71833"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.34/grove-x86_64-apple-darwin.tar.gz"
      sha256 "e23fa883f4dafb788c3e4bdbfc076af81d535471a8625bf20a6155832e29af60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.34/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e8ddd01fbd5b949d7c97b9a7589cd9ee04fea9ff33483e0b5c67550de3c92a0f"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.34/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d5ab74f7316df92b3feb41730b6f984caa405ef52b98d1049f89eed4626020af"
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
