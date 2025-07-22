class Merchant < Formula
  desc "A terminal UI game."
  homepage "https://github.com/samgqroberts/merchant"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/samgqroberts/merchant/releases/download/v1.0.3/merchant-aarch64-apple-darwin.tar.xz"
      sha256 "8abe26f46f80ae3c8dd5bb73414b5be27027f2ae42bdb43eb23881e28ee6ba3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/samgqroberts/merchant/releases/download/v1.0.3/merchant-x86_64-apple-darwin.tar.xz"
      sha256 "f064fa1052ecfef2e6ffd9ab87bb532e3cd3ef8243cf127e033cbd7d3ba1e21a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/samgqroberts/merchant/releases/download/v1.0.3/merchant-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "2a2a9bc6b7359c28ec2f8a506626d1a449feefc6c607aa10ef1eae4ced3b7cb5"
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
