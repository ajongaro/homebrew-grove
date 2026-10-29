# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.23/grove-aarch64-apple-darwin.tar.gz"
      sha256 "08faece880c9dac116889bcb694865702f7e909c8b3d415288b87e8d66155fd4"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.23/grove-x86_64-apple-darwin.tar.gz"
      sha256 "8f5057e95fe20c7bae96586642177c5723a5f5b256477b121c4af51fc45b0b6b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.23/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fd4841675c3a0cb46577c9d241aa16ec2735d808fc83d9d495f54ca91f27f9a7"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.23/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b338dcf859ae0f47cffb97f3c56ba120036cfd94a12fcd525022a8f8cd83d5cd"
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
