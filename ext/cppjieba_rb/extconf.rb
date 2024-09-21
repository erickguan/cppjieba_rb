# frozen_string_literal: true

require 'mkmf'
abs = __dir__

LIBDIR      = RbConfig::CONFIG['libdir']
INCLUDEDIR  = RbConfig::CONFIG['includedir']

HEADER_DIRS = [
  INCLUDEDIR,
  "#{abs}/../cppjieba/include",
  "#{abs}/../cppjieba/deps/limonp/include"
].freeze

LIB_DIRS = [
  LIBDIR
].freeze

dir_config('cppjieba_rb', HEADER_DIRS, LIB_DIRS)

# rubocop:disable Style/GlobalVars
CONFIG['CXXFLAGS'] += ' -std=c++11 -O3'
$CXXFLAGS = "#{$CXXFLAGS} -std=c++11 -O3"
# rubocop:enable Style/GlobalVars

create_makefile 'cppjieba_rb/cppjieba_rb'
# respect header changes
headers = Dir.glob('*.{hpp,h}').join ' '
File.open 'Makefile', 'a' do |f|
  f.puts "\n$(OBJS): #{headers}"
end
