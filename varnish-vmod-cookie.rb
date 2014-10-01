require 'formula'

class VarnishVmodCookie < Formula
  homepage 'https://github.com/in2pire/libvmod-cookie'
  url 'https://github.com/in2pire/libvmod-cookie/archive/master.tar.gz'
  sha1 '99e650f8775802c86a0bd56cb2845429f24ccd02'
  head 'https://github.com/in2pire/libvmod-cookie.git'
  version '1.x-dev'

  depends_on 'pkg-config' => :build
  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pcre'
  depends_on 'varnish'

  resource "docutils" do
    url "https://pypi.python.org/packages/source/d/docutils/docutils-0.11.tar.gz"
    sha1 "3894ebcbcbf8aa54ce7c3d2c8f05460544912d67"
  end

  def install
    varnish_prefix = "#{Formula['varnish'].prefix}"

    ENV['VARNISHAPI_CFLAGS'] = "-I#{varnish_prefix}/include/varnish"
    ENV['VARNISHAPI_LIBS'] = "-L#{varnish_prefix}/lib -lvarnishapi"

    ENV.prepend_create_path "PYTHONPATH", buildpath + "lib/python2.7/site-packages"
    resource("docutils").stage do
      system "python", "setup.py", "install", "--prefix=#{buildpath}"
    end

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-rst2man=#{buildpath}/bin/rst2man.py",
                          "--with-rst2html=#{buildpath}/bin/rst2html.py"

    system "make"
    system "make install"
  end
end
