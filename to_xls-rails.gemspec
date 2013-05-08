# encoding: utf-8

version = File.read(File.expand_path("../VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.name = 'to_xls-rails'
  s.version = version
  s.author = "Mike Liang"
  s.email = "liangwenke.com@gmail.com"
  s.homepage = "http://github.com/liangwenke/to_xls-rails"
  s.summary     = "Export Rails ActiveRecord data to excel file"
  s.description = "This simple plugin gives you the ability to call to_xls to a collection of activerecords for Rails."

  s.files        = Dir["{lib,test}/**/*", "[a-zA-Z]*", "init.rb"] - ["Gemfile.lock"]
  s.require_path = "lib"

  s.add_dependency('spreadsheet', '>= 0.8.5')

  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = ">= 1.3.4"
end
