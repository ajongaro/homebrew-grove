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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.47/grove-aarch64-apple-darwin.tar.gz"
      sha256 "45cd6adae48cdd2538fc2453151a98fdfa5e8753565a5614c9602cfcc6b5c76c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.47/grove-x86_64-apple-darwin.tar.gz"
      sha256 "80868eff8a3aff8d0b7213bbdd247c3582ace88a24ea5a0606133d0d7800b768"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.47/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e7c6ad79b6479b29123cceeed96d4f0160acfbd1b6ca865e1b439d97334fb4ca"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.47/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5a76f314285deb445fa33e0eb5a29da1781c0aaa47970f20f3f66305d12f8c4c"
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
