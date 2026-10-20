# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.7/grove-aarch64-apple-darwin.tar.gz"
      sha256 "16d42b6a2b6911ff5f9502f87969845e02a8c4acc611a962d2f9e51f47111d43"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.7/grove-x86_64-apple-darwin.tar.gz"
      sha256 "b4e754b368839c5e04392d480cb4bb50cc4a9dc86369d366d98a47e2995baa30"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.7/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f12477adc3d5a49ea5e704bfa67714d227ff1507a947e5043b2b2ad592a13872"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.7/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a5e0c7008cff3fa3df6ba6cd01ddc57cf9195f0e23569248a7780a3cbbd6dced"
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
