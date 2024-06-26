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
    url "https://github.com/ruimarinho/gsts/commit/f2dfea1e0f3f7c439988b781e861d5ecf1dd9bbb.patch?full_index=1"
    sha256 "948fe5540006f570403c93d19af44c2ec2b311800804eb5a3b9a3cdb7dd081c2"
  end
  patch do
    url "https://github.com/ruimarinho/gsts/commit/668f85ca097b20268382ff8c90ab30fdfd74a28d.patch?full_index=1"
    sha256 "fc20c1f569bf50a15083f8cecf6000b87ccb3909035739dce9e5933bb9d29476"
  end

  # https://github.com/ruimarinho/gsts/pull/114
  patch do
    url "https://github.com/ruimarinho/gsts/commit/27250e5c25aaf78998abbc4ad5909d839dd85f18.patch?full_index=1"
    sha256 "c0c94f809d92a2760ac3db5f6de25b3c3156c1fda4a131f224793a87d42f0f79"
  end
  patch do
    url "https://github.com/ruimarinho/gsts/commit/3ccd2953ede583cab2aa7eca1a0d4b7aa349bb2f.patch?full_index=1"
    sha256 "1eaa2fa318f227fde1dd0ec6c9dbe72269867b3bc485b3c270f4be622e575037"
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
