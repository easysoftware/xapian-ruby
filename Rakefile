# encoding: utf-8
# Install the xapian binaries into the lib folder of the gem
require 'rbconfig'

c = RbConfig::CONFIG

def system!(cmd)
  puts cmd
  system(cmd) or raise
end

source_dir = 'xapian_source'
core = "xapian-core"
bindings = "xapian-bindings"
xapian_config = "#{Dir.pwd}/#{core}/xapian-config"
swig = "swig"

task :default do
  [core, bindings, swig].each do |x|
    system! "tar -xJf #{source_dir}/#{x}.tar.xz"
  end

  prefix = Dir.pwd
  ENV['LDFLAGS'] = "-L#{prefix}/lib"
  ENV['CXXFLAGS'] = "-fms-extensions"

  system! "mkdir -p lib"

  Dir.chdir core do
    system! 'sed -i".bak" -e "s/darwin\\[91\\]/darwin[912]/g" configure'
    system! "./configure --prefix=#{prefix} --exec-prefix=#{prefix} --enable-64bit-docid --enable-64bit-termcount --enable-64bit-termpos --disable-documentation"
    system! "make"
    system! "cp -r .libs/* ../lib/"
  end

  Dir.chdir swig do
    system! "./autogen.sh"
    system! "./configure"
    system! "make"
  end

  Dir.chdir bindings do
    system! 'sed -i".bak" -e "s/darwin\\[91\\]/darwin[912]/g" configure'
    ENV['RUBY'] ||= "#{c['bindir']}/#{c['RUBY_INSTALL_NAME']}"
    ENV['XAPIAN_CONFIG'] = xapian_config
    ENV['SWIG'] = "#{prefix}/#{swig}/preinst-swig"
    system! "./configure --prefix=#{prefix} --exec-prefix=#{prefix} --with-ruby --enable-maintainer-mode --disable-documentation"
    system! "make"
  end

  system! "cp -r #{bindings}/ruby/.libs/_xapian.* lib"
  system! "cp #{bindings}/ruby/xapian.rb lib"

  system! "rm lib/*.a"
  system! "rm lib/*.la"
  system! "rm lib/*.lai"

  system! "rm -R #{swig}"
  system! "rm -R #{bindings}"
  system! "rm -R #{core}"
  system! "rm -R #{source_dir}"
end
