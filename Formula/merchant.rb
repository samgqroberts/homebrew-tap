class Merchant < Formula
  desc "A terminal UI game."
  homepage "https://github.com/samgqroberts/merchant"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/samgqroberts/merchant/releases/download/v0.5.0/merchant-aarch64-apple-darwin.tar.xz"
      sha256 "1b4f1ee9eb75b42d55662f74f48ac93c1d682268ad28dd6f5180ad0b95901f6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/samgqroberts/merchant/releases/download/v0.5.0/merchant-x86_64-apple-darwin.tar.xz"
      sha256 "b1398d59805d7bc0a200621aa19583e92050a0d501dd269dbecd4c3545584842"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/samgqroberts/merchant/releases/download/v0.5.0/merchant-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "5dfbbd5e83f676b0dde13b3598fdde181778dce08184c10e4470af49a7425fa0"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "merchant" if OS.mac? && Hardware::CPU.arm?
    bin.install "merchant" if OS.mac? && Hardware::CPU.intel?
    bin.install "merchant" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
