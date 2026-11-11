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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.40/grove-aarch64-apple-darwin.tar.gz"
      sha256 "d192a5eb0cc1e341f85b554ddc06c497a8b077ab3979a816784e74f3bb938133"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.40/grove-x86_64-apple-darwin.tar.gz"
      sha256 "f4b759a3fd7ca6cfdfe55bcead046fd49ebcd93731457f16cff5d6d88c2e59e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.40/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6eaec56eb99f203a231e0fef9d82303b1498c5129cbabd3036f551afbb972531"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.40/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2a4baa0a10849b1fbdfa776699c42dab74a107c12ad37dd4df1e3571c3317c23"
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
