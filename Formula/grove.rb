# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.4/grove-aarch64-apple-darwin.tar.gz"
      sha256 "e4ee08c98a19afa79641d292ce5969ec82ab71b49ffb7b74bc757e056b9418d5"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.4/grove-x86_64-apple-darwin.tar.gz"
      sha256 "dc049536b0e894a791f2f8cf9c5ca6ecc5ff76375541ad34c2d70f18a4bc6cec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.4/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4e9064fd7e8f0cd4d62d9add41b437c4d2c4dad9b8e4e5d398fd05aa9ab2972a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.4/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2c18d930102831ab37c54f3d06513e86b3d91e10984a332a57503875b4c711dc"
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
