class Merchant < Formula
  desc "A terminal UI game."
  homepage "https://github.com/samgqroberts/merchant"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/samgqroberts/merchant/releases/download/v1.0.4/merchant-aarch64-apple-darwin.tar.xz"
      sha256 "c7e12b700ba972d4d74879449646a1e97340492ab0f5ef26517098206317ffc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/samgqroberts/merchant/releases/download/v1.0.4/merchant-x86_64-apple-darwin.tar.xz"
      sha256 "259274954a3ff5be6098a3e85ac00101cf35877c82f0fda37eed0b3f62fbcb83"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/samgqroberts/merchant/releases/download/v1.0.4/merchant-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "230d7bc3fa313359c7ceccc810a28dfb5b947c1054b64a03edfb2aee54544633"
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
