# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.21/grove-aarch64-apple-darwin.tar.gz"
      sha256 "2b4fa3baf166ae809c694db1e303d73029a6a9202f64987365afe876c6f56bc3"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.21/grove-x86_64-apple-darwin.tar.gz"
      sha256 "1efff053ab243318bd7b903fe016f93164b98ff48f22d25c38b610256d3288cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.21/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b678beae6cd1883d52dd13c335a4a9be82241ccb0f494784326233faf0781121"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.21/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c0ed65ae0c4c580fac626f30abf7efedd922b1b93da79ec522e76387f3a90ce5"
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
