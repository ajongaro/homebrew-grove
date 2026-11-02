# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.26/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1a3d0f81e0f4ea6223ff911401daf01a7650e6822da414f36b9f12aebe9443fa"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.26/grove-x86_64-apple-darwin.tar.gz"
      sha256 "71951e0b1a5ae70491cf78ea7662bc3759e8cf7a8ecff02c8663b56c7a6013b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.26/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "bcb492c1de6f51df87acef5e0543bc409b84fdce2b29066a21ac8115860c18b6"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.26/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fa667a799c7a1530abe460edb4a31feeff2bb73c03aeed6c3cae8e01f0c2802c"
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
