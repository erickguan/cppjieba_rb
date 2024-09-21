# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/extensiontask'

gem = Gem::Specification.load("#{File.dirname(__FILE__)}/cppjieba_rb.gemspec")
Rake::ExtensionTask.new('cppjieba_rb', gem) do |ext|
  ext.lib_dir = File.join('lib', 'cppjieba_rb')
end

Rake::Task[:test].prerequisites << :compile

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'clean compile files'
task :clean_compile do
  system 'rm -r tmp'
  system 'rm lib/*.bundle'
end

task default: :test

desc 'report gem version'
task :version do
  print CppjiebaRb::VERSION
end
