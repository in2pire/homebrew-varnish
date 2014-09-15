require "formula"

class VarnishVmodCookie < Formula
  init
  homepage 'https://github.com/lkarsten/libvmod-cookie'
  url 'https://github.com/lkarsten/libvmod-cookie/archive/libvmod-cookie-1.21.zip'
  sha1 '66230f4c0c2128c3fb6f57a8cb41f8628361c280'
  head 'https://github.com/lkarsten/libvmod-cookie.git'

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on 'pkg-config' => :build
  depends_on 'pcre'
  depends_on 'varnish'

  def install
  end
end
