class Merchant < Formula
  desc "A terminal UI game."
  homepage "https://github.com/samgqroberts/merchant"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/samgqroberts/merchant/releases/download/v0.4.5/merchant-aarch64-apple-darwin.tar.xz"
      sha256 "13ac910495233c594a9ad3dbfc02f44a5dbf0fc59e5648fbfd9aa21d9dd7b695"
    end
    if Hardware::CPU.intel?
      url "https://github.com/samgqroberts/merchant/releases/download/v0.4.5/merchant-x86_64-apple-darwin.tar.xz"
      sha256 "ccefd44a10981ab91b3a86aa4efd01ec1217f0b0e01f77ac9304ba3c54c35790"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/samgqroberts/merchant/releases/download/v0.4.5/merchant-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "f85910b2b71b7a2f61a69099bb76d8821396fa25b931a7678bbcf82c52db81ff"
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
