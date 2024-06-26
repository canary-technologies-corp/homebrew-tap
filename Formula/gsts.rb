require "language/node"

class Gsts < Formula
  desc "Obtain and store AWS STS credentials by authenticating via G Suite SAML"
  homepage "https://github.com/ruimarinho/gsts"
  url "https://github.com/ruimarinho/gsts/archive/refs/tags/v5.0.4.tar.gz"
  sha256 "1ba1b5dca60cb59c984a6c49ad8a87e658eec00d296109c5bf5fb2b2e7b810a8"
  license "MIT"

  depends_on "node"

  # https://github.com/ruimarinho/gsts/pull/111
  patch do
    url "https://github.com/ruimarinho/gsts/commit/f2dfea1e0f3f7c439988b781e861d5ecf1dd9bbb.patch"
    sha256 "be8f12ff15e4b34e9823571f3afce7f213aaa5dbbd6a78d4b4a271d9476f29d1"
  end
  patch do
    url "https://github.com/ruimarinho/gsts/commit/668f85ca097b20268382ff8c90ab30fdfd74a28d.patch"
    sha256 "cf0e2e7174be934a68743575d65d0c37377f5fe8a4b77c3c2426fb1b3fd0b951"
  end

  # https://github.com/ruimarinho/gsts/pull/114
  patch do
    url "https://github.com/ruimarinho/gsts/commit/27250e5c25aaf78998abbc4ad5909d839dd85f18.patch"
    sha256 "2b97e37023936f917ccac2de87320cd11965ec55ecfb0f1cc14eaa8486334da8"
  end
  patch do
    url "https://github.com/ruimarinho/gsts/commit/3ccd2953ede583cab2aa7eca1a0d4b7aa349bb2f.patch"
    sha256 "a64f83a815226d4517be2cb6d65e239106309d47c091ae5fa5b9b699919594dc"
  end

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    (bin/"gsts").write_env_script libexec/"lib/node_modules/gsts/index.js", PLAYWRIGHT_BROWSERS_PATH: "0"
  end

  def post_install
    ENV["PLAYWRIGHT_BROWSERS_PATH"]="0"

    system "#{Formula["node"].bin}/node", "#{libexec}/lib/node_modules/gsts/node_modules/playwright/cli.js", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gsts --version")
  end
end
