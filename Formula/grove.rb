# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.24/grove-aarch64-apple-darwin.tar.gz"
      sha256 "590f5d1603a8f762f8b83638e6cb785e8b06ab7201ec35ea809247b38030efd1"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.24/grove-x86_64-apple-darwin.tar.gz"
      sha256 "75be82d6f3a5543ea5f343534cc15d3578579fc0e8e839d12d01c14ed5d61b52"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.24/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "92b581f241dfd44c228c08d69d939d5f1a91ff6343beb1c2ed06173456050242"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.24/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "597fc2bbec38c557453063290b9eb5b61035ec09b5aa1a8879ff6c4aace3b901"
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
