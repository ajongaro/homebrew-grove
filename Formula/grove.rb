# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.14/grove-aarch64-apple-darwin.tar.gz"
      sha256 "2c2528e04fc5d10e8a43ded459f3f58d8b0ce90bbb17375b88bb6d6bcf36b5dc"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.14/grove-x86_64-apple-darwin.tar.gz"
      sha256 "fab44bf8ab7c6152986c73032cec09a7a4164135f96e536561cc0c637b188a1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.14/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "539fd74f64751e1c83a7bb83166cda22309dbf14635621df3685bdce1fd9861f"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.14/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "687b07b32f4b35d4cb125b6be198a5d6373ea2612f4fd7df70bcd0b8cd64de90"
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
