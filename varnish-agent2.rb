require 'formula'

class VarnishAgent2 < Formula
  homepage 'https://github.com/varnish/vagent2'
  url 'https://github.com/varnish/vagent2/archive/4.0.0-RC2.zip'
  sha1 'f191c0d3ad71b1bd2357996acf578bd4a3ab42e4'
  head 'https://github.com/varnish/vagent2.git'
  version '4.0.0-rc2'

  patch :DATA

  depends_on 'pkg-config' => :build
  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pcre'
  depends_on 'libmicrohttpd'

  resource "docutils" do
    url "https://pypi.python.org/packages/source/d/docutils/docutils-0.11.tar.gz"
    sha1 "3894ebcbcbf8aa54ce7c3d2c8f05460544912d67"
  end

  def install
    ENV['VARNISHAPI_CFLAGS'] = "-I#{Formula['varnish'].opt_prefix}/include/varnish"
    ENV['VARNISHAPI_LIBS'] = "-L#{Formula['varnish'].opt_prefix}/lib -lvarnishapi"

    ENV.prepend_create_path "PYTHONPATH", buildpath+"lib/python2.7/site-packages"
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

__END__
diff --git a/autogen.sh b/autogen.sh
index a5c9695..bf8c0b0 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -19,7 +19,7 @@ fi

 set -ex

-aclocal -I /usr/share/aclocal
+aclocal -I /usr/local/share/aclocal
 autoheader
 automake --add-missing --copy --foreign
 autoconf
