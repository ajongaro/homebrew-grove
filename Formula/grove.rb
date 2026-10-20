# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.8/grove-aarch64-apple-darwin.tar.gz"
      sha256 "da8c7c26c2ac1ae3f45a218c27e72b7f1b2174ea57c99662659a412cf57b91d9"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.8/grove-x86_64-apple-darwin.tar.gz"
      sha256 "a0f4d05fb77dee4f627a4be633b8c64afdf8bf6ce498f9616bb9f042803083be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.8/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cdadc4125f6dc9fa3004e522a747a72a810da9f156fdcc0dd0a69d0c9a168d5b"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.8/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "35e37d1baae8563aa541a347b92fc9cc46ea722587129030c9952c0307609e6e"
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
