class Merchant < Formula
  desc "Terminal UI game"
  homepage "https://github.com/samgqroberts/merchant"
  url "https://github.com/samgqroberts/merchant/releases/download/v0.1.0/merchant-0.1.0-x86_64-apple-darwin.tar.gz"
  sha256 "277332ebb5fb7fb0c80db2e25d1abe0ce39b4015407eff3294d4d145afac41d7"
  version "0.1.0"

  def install
    bin.install "merchant"
  end
end
