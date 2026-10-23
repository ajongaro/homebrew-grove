# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.22/grove-aarch64-apple-darwin.tar.gz"
      sha256 "a4980635f3ecb8cd18e63d5cd10539f2f8868b82e6b3594b2eb7cb8a1013fa9a"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.22/grove-x86_64-apple-darwin.tar.gz"
      sha256 "359eb67ad6c5e14a1a427b1b61ab931efd5a744f566047d9f55419c885401758"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.22/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "181d0b3e47a1e11e1cc86e68b103204bbf4fc822ce6cfe6627bcef265db010a7"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.22/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "310c34768e48e5d94a09e3f429da2b86d8eb8a02bfd727ed0d95a92850735d3a"
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
