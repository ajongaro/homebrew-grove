# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.17/grove-aarch64-apple-darwin.tar.gz"
      sha256 "2678066b473f2496a50a67b82031552e1981eee042bbd653103fcf8905d8aceb"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.17/grove-x86_64-apple-darwin.tar.gz"
      sha256 "44fd861713aef3e779e31a3ff3fa0a35e3471ba751b1a21b6792cf7815a8de0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.17/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "137e7dad13baeea7cfe925f024fc6a41f5de0d7772f2b751bfb9c999eb532f0d"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.17/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "645b9afd2fcc82943295cb3cbfed21fd913ce1f60d55cda99d0e9e83e7fa5c6b"
    end
  end

  def install
    bin.install "grove"
  end

  def caveats
    <<~EOS
      Grove needs Claude Code, logged in: https://code.claude.com/docs
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
