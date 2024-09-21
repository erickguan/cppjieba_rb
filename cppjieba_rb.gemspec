# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cppjieba_rb/version'

# Recursive function to handle submodules and their submodules
def collect_submodule_files(spec, relative_path, submodule_dir)
  Dir.chdir(submodule_dir) do
    submodule_relative_path = submodule_dir.gsub(relative_path, '')

    # Get all files in the current submodule
    submodule_files = `git ls-files -z`.split("\x0")
    submodule_files.each do |file|
      # Add the relative submodule path to each file
      spec.files << File.join(submodule_relative_path, file)
    end

    # Recurse into any submodules of the current submodule
    nested_submodules = `git submodule foreach --quiet pwd`.split("\n")
    nested_submodules.each do |nested_submodule_path|
      if (ENV['OS'] == 'Windows_NT') && nested_submodule_path.start_with?('/')
        # Handle cygwin-style paths on Windows
        nested_submodule_path = nested_submodule_path[1..] # Remove leading slash
        nested_submodule_path.insert(1, ':') # Add drive letter (e.g., C:)
      end
      collect_submodule_files(spec, relative_path, nested_submodule_path)
    end
  end
end

Gem::Specification.new do |spec|
  spec.name          = 'cppjieba_rb'
  spec.version       = CppjiebaRb::VERSION
  spec.authors       = ['Erick Guan']
  spec.email         = ['erickguanst@gmail.com']
  spec.summary       = 'cppjieba binding for ruby'
  spec.description   = 'cppjieba binding for ruby. Mainly used by Discourse.'
  spec.homepage = 'https://github.com/erickguan/cppjieba_rb'
  spec.required_ruby_version = '>=2.7.0'
  spec.license = 'MIT'
  spec.extensions = ['ext/cppjieba_rb/extconf.rb']

  spec.files = `git ls-files -z`.split("\x0")
  relative_path = "#{File.expand_path(__dir__)}/"

  # Collect files from all submodules recursively
  submodules = `git submodule foreach --quiet pwd`.split("\n")
  submodules.each do |submodule_path|
    if (ENV['OS'] == 'Windows_NT') && submodule_path.start_with?('/')
      # Handle cygwin-style paths on Windows
      submodule_path = submodule_path[1..] # Remove leading slash
      submodule_path.insert(1, ':') # Add drive letter (e.g., C:)
    end

    collect_submodule_files(spec, relative_path, submodule_path)
  end

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib'] # to pick up the compiled shared library.

  spec.metadata['rubygems_mfa_required'] = 'true'
end
