# encoding: utf-8

version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name = 'to_xls-rails'
  s.version = version
  s.author = "LiangWenKe"
  s.email = "liangwenke.com@gmail.com"
  s.homepage = "http://github.com/liangwenke8/to_xls-rails"
  s.summary     = "Export data to xls on Rails"
  s.description = "This simple plugin gives you the ability to call to_csv to a collection of activerecords. The builder options are the same as to_json / to_xml, except for the :include."
  
  s.files        = Dir["{lib,test}/**/*", "[a-zA-Z]*", "init.rb"] - ["Gemfile.lock"]
  s.require_path = "lib"
  
  s.add_development_dependency('spreadsheet', '~>0.6.5')

  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = ">= 1.3.4"
end
