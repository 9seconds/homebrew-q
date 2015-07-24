# -*- mode: ruby -*-
# vi: set ft=ruby :


class Q < Formula
  homepage "https://github.com/9seconds/q"
  url "https://github.com/9seconds/q.git", using: :git, :tag => "0.1.0"
  sha1 ""

  head "https://github.com/9seconds/q.git", using: :git

  bottle do
    sha1 "7563b28df830baa880731b9448e88b99dcb68420" => :mavericks
    sha1 "4ecba686ae851cb091bec58aebab1c092a5edfbf" => :mountain_lion
    sha1 "697f44626b6dd3152fb23d6da8272cb2359a6845" => :lion
  end

  depends_on "pcre" => :build
  depends_on "autoconf" => :build
  depends_on "rust" => :build

  conflicts_with "q", :because => "https://github.com/harelba/q also ships a q binary"

  def install
    system "cargo", "build", "--release"
    bin.install "target/release/q"
    man1.install "man/q.1"
  end

  test do
    system "#{bin}/q", "--help"
  end
end
