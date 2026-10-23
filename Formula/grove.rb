# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.19/grove-aarch64-apple-darwin.tar.gz"
      sha256 "a9df11437122863c178976c32ab04eb48aa654312850e2090693ff498b5c4d9b"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.19/grove-x86_64-apple-darwin.tar.gz"
      sha256 "fdb655a3c8a16808b6e8ac70379b55116dec7e57c47dd1e0f4586258ae0622ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.19/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a1f38a9113606fa9d72d865831eb4960608cb4d2f2efe651775345f7b9234464"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.19/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a93752916837190cd020526e0e6fcb4993af2a203313c5188f8c481f7a9fc60a"
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
