# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.1/grove-aarch64-apple-darwin.tar.gz"
      sha256 "69d42ee9330a23436d829141db4e161e328592fb0255aabd5370da9f84004832"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.1/grove-x86_64-apple-darwin.tar.gz"
      sha256 "58c52cd97af65eb8f65f9ab401048ccceeb3e38304191699dac56550a2211928"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.1/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c9bca3f22a5abe4edb3c7d699d5a6a7ce8a6b35fb1ccf46a868755b40d11431c"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.1/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3f9ae9a604166dc6fc645852fc6ed5219f0f4bf6d2eedc699be3e3607369e27b"
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
