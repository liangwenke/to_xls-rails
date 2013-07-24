# encoding: utf-8

version = File.read(File.expand_path("../VERSION", __FILE__)).strip

Gem::Specification.new do |spec|
  spec.name                      = 'to_xls-rails'
  spec.version                   = version
  spec.author                    = "Mike Liang"
  spec.email                     = "liangwenke.com@gmail.com"
  spec.homepage                  = "http://github.com/liangwenke/to_xls-rails"
  spec.summary                   = "Export Rails ActiveRecord data to excel file"
  spec.description               = "This simple plugin gives you the ability to call to_xls to a collection of activerecords for Rails."

  spec.files                     = Dir["{lib,test}/**/*", "[a-zA-Z]*", "init.rb"] - ["Gemfile.lock"]
  spec.require_path              = "lib"
  spec.license                   = 'MIT'

  spec.add_dependency('spreadsheet', '>= 0.8.5')

  spec.platform                  = Gem::Platform::RUBY
  spec.required_rubygems_version = ">= 1.3.4"
end
