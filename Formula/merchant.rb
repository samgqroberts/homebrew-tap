class Merchant < Formula
  desc "Terminal UI game"
  homepage "https://github.com/samgqroberts/merchant"
  on_arm do
    url "https://github.com/samgqroberts/merchant/releases/download/v0.2.0/merchant-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "e1d80ee8a84c4343d1df3eb9e8ff7801651b50cf3790326cd30172e69ce6287d"
  end
  on_intel do
    url  "https://github.com/samgqroberts/merchant/releases/download/v0.2.0/merchant-0.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "b797840894cf41d0038ffe9410a7ee46ce069bd49c891f4f9661b663a3b24406"
  end
  version "0.2.0"

  def install
    bin.install "merchant"
  end
end
