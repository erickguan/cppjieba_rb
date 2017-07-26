require "mkmf"
abs = File.expand_path File.dirname(__FILE__)

LIBDIR      = RbConfig::CONFIG['libdir']
INCLUDEDIR  = RbConfig::CONFIG['includedir']

HEADER_DIRS = [
  INCLUDEDIR,
  "#{abs}/../cppjieba/include",
  "#{abs}/../cppjieba/deps"
]

LIB_DIRS = [
  LIBDIR
]

dir_config('cppjieba_rb', HEADER_DIRS, LIB_DIRS)

CONFIG["CXXFLAGS"] += " -std=c++11 -O3"
$CXXFLAGS = "#{$CXXFLAGS} -std=c++11 -O3"
create_makefile 'cppjieba_rb/cppjieba_rb'
# respect header changes
headers = Dir.glob('*.{hpp,h}').join ' '
File.open 'Makefile', 'a' do |f|
  f.puts "\n$(OBJS): #{headers}"
end
