# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.25/grove-aarch64-apple-darwin.tar.gz"
      sha256 "d263f41ee2d533649f1adfffe52cc4fe0a3ae7e977c95d1a7d0728820eb69f59"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.25/grove-x86_64-apple-darwin.tar.gz"
      sha256 "83d4c7a4cd3fe1af1cac22e6f60a443f8af653aa2dc2883e10cb3da24fa73cb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.25/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "73e3873afe69711a6a758ea115046a962e3af21049f3ff651296f5922374ab41"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.25/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "08c463e15fec2720a42a1cc9ad55d5ab4016d84ea63f9246318b659a486e13d0"
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
