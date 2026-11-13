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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.53/grove-aarch64-apple-darwin.tar.gz"
      sha256 "bb42e56d324aa70c02e855f199be879fa5e8e174ab23a29ae60c5f4781eace0c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.53/grove-x86_64-apple-darwin.tar.gz"
      sha256 "2338c56dd0ce68b3430de8ba31880ed33244b83994f0195891131e75828c414e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.53/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e29658056f53c655bfefcf5151c4dbaaf4f019f7f325942996a7b6fdaef79bcd"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.53/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b3984259c1725ea926cd68cdc952defde8870dbe1bb852f70216eace972bc8a8"
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
