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
      url "https://github.com/ajongaro/grove/releases/download/v0.1.28/grove-aarch64-apple-darwin.tar.gz"
      sha256 "56d16b07dd588c9555041850b42c74c0b2e96d954f1aac0c8b1503d55eb28dca"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.28/grove-x86_64-apple-darwin.tar.gz"
      sha256 "a66bdef7cc0be429cd0237803ab363d4e99e29fdce801e9ecd290f1e117afb83"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.28/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0be617272e96c0cb577eb8609464fb2543d49c89e511358fe6cc75b210bb307f"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.28/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "97776a6d167c5469623b02cd27dbb997328a0ed5444f6a00b0c451c817f712b8"
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
