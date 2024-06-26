require "language/node"

class Gsts < Formula
  desc "Obtain and store AWS STS credentials by authenticating via G Suite SAML"
  homepage "https://github.com/ruimarinho/gsts"
  url "https://github.com/ruimarinho/gsts/archive/v5.0.4.tar.gz"
  sha256 "1ba1b5dca60cb59c984a6c49ad8a87e658eec00d296109c5bf5fb2b2e7b810a8"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    (bin/"gsts").write_env_script libexec/"lib/node_modules/gsts/index.js", PLAYWRIGHT_BROWSERS_PATH: "0"
  end

  def post_install
    ENV["PLAYWRIGHT_BROWSERS_PATH"]="0"

    system "#{Formula["node"].bin}/node", "#{libexec}/lib/node_modules/gsts/node_modules/playwright/cli.js", "install"
  end

  patch do
    url "https://github.com/ruimarinho/gsts/pull/111.patch"
    sha256 "5c5d3104aa195e083a0e4cbba5fe67adce1990f704e79246e8f4c70548c2945b"
  end

  patch do
    url "https://github.com/ruimarinho/gsts/pull/114.patch"
    sha256 "8d21a09a12047d0db858f455703c69dc9d44b324a8b6288527f991c0f1fc806d"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gsts --version")
  end
end
