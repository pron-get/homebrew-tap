class PronGet < Formula
  desc "Apt-style package manager for porn, over Tor"
  homepage "https://github.com/pron-get/pron-get"
  url "https://github.com/pron-get/pron-get/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "0cefafc850b40cce0bb4593b9c4af585bbcceab297180f9602fd45159a8c1670"
  license "GPL-2.0-or-later"

  depends_on "go" => :build
  depends_on "tor"
  depends_on "ffmpeg" => :recommended

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "./cmd/pron-get"
    bin.install_symlink "pron-get" => "pron-cache"
    man1.install "man/pron-get.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pron-get version")
    assert_match "Super Cow Powers", shell_output("#{bin}/pron-get moo; #{bin}/pron-get help")
  end
end
