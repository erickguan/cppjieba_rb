# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cppjieba_rb/version'

Gem::Specification.new do |spec|
  spec.name          = 'cppjieba_rb'
  spec.version       = CppjiebaRb::VERSION
  spec.authors       = ['Erick Guan']
  spec.email         = ['fantasticfears@gmail.com']
  spec.summary       = 'cppjieba binding for ruby'
  spec.description   = 'cppjieba binding for ruby. Mainly used by Discourse.'
  spec.homepage = 'https://github.com/fantasticfears/cppjieba_rb'
  spec.required_ruby_version = '>=2.3.0'
  spec.license       = 'MIT'
  spec.extensions = ['ext/cppjieba_rb/extconf.rb']

  spec.files         = `git ls-files -z`.split("\x0")
  relative_path = File.expand_path('../', __FILE__) + '/'
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    if (ENV['OS'] == 'Windows_NT') && submodule_path[0] == '/'
      # Detect if cygwin path is being used by git
      submodule_path = submodule_path[1..-1]
      submodule_path.insert(1, ':')
    end
    # for each submodule, change working directory to that submodule
    Dir.chdir(submodule_path) do
      # Make the submodule path relative
      submodule_path = submodule_path.gsub(/#{relative_path}/i, '')
      # issue git ls-files in submodule's directory
      submodule_files = `git ls-files -z`.split("\x0")

      # prepend the submodule path to create relative file paths
      submodule_files_paths = submodule_files.map do |filename|
        File.join(submodule_path, filename)
      end
      # add relative paths to gem.files
      spec.files += submodule_files_paths
    end
  end

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.2', '>= 2.2.10'
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'rake-compiler', '~> 1.1'
  spec.add_development_dependency 'minitest', '~> 5.14'
end
