require "language/haskell"

class Hlint < Formula
  include Language::Haskell::Cabal

  desc "Haskell source code suggestions"
  homepage "https://github.com/ndmitchell/hlint"
  url "https://hackage.haskell.org/package/hlint-2.0.12/hlint-2.0.12.tar.gz"
  sha256 "7e81be91b9ba30274658b95c30f02d5b2a08489363906371b787b002c323d8b1"
  head "https://github.com/ndmitchell/hlint.git"

  bottle do
    sha256 "593dffc0966fbf21f45096879d22ee7a40d1dd7d71a7795e2a0e432541436bc9" => :high_sierra
    sha256 "8890dd4f76a6929a29394b019901c9406f4bf6a46df40c640c8d224894ab3375" => :sierra
    sha256 "e6bd33d728fdba5bb3a85ca8021ca3e862d1efed8f995ac60875fbd943b52f5c" => :el_capitan
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    install_cabal_package :using => "happy"
    man1.install "data/hlint.1"
  end

  test do
    (testpath/"test.hs").write <<~EOS
      main = do putStrLn "Hello World"
    EOS
    assert_match "Redundant do", shell_output("#{bin}/hlint test.hs", 1)
  end
end
