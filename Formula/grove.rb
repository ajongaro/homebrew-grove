# Written by scripts/formula.sh in ajongaro/grove; don't edit by hand.
class Grove < Formula
  desc "Dashboard for Claude Code sessions, in tmux"
  homepage "https://github.com/ajongaro/grove"
  license "MIT"

  # On Linux, the system's tmux: a second one from Homebrew means whichever
  # a shell finds first starts Grove's server, and an older one can't reach
  # a server a newer one started.
  on_macos do
    depends_on "tmux"

    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.55/grove-aarch64-apple-darwin.tar.gz"
      sha256 "1c9f83b1c94ee56ee287def5d1ba5383a18a2bf65447694236b7a9af7807e195"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.55/grove-x86_64-apple-darwin.tar.gz"
      sha256 "339c3deea768bf66b3e9939e2b3b5ef5394d66f13f587eb3e9349ee7426acffa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.55/grove-aarch64-unknown-linux-musl.tar.gz"
      sha256 "36db6d1f11869c4e4ca09f07e3c7973862bac456f155f4a19e4d3c7b06218417"
    end
    on_intel do
      url "https://github.com/ajongaro/grove/releases/download/v0.1.55/grove-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3b197a59c8a92dd2cba98bd8925a2e913c98e1b17d32aa1ce87c84e822412e6e"
    end
  end

  def install
    bin.install "grove"
  end

  def caveats
    <<~EOS
      Grove needs Claude Code, logged in: https://code.claude.com/docs
      On Linux it uses your system's tmux (3.2 or newer): sudo apt install tmux
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
