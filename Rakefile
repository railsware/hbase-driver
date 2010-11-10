require 'rake/gempackagetask'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = "spec/**/[^_]*_spec.rb"
end

task :default => :spec

spec = Gem::Specification.new do |s| 
  s.name = "hbase-driver"
  s.version = '0.0.1'
  s.summary = "HBase Ruby Driver"
  s.homepage = "http://github.com/railsware/hbase-driver"
  s.email = ["Alexey.Petrushin@railsware.com", "dmitry.larkin@railsware.com"]
  s.authors = ["Alexey Petrushin", "Dmitry Larkin"]
  s.files = FileList["{lib}/**/*"].to_a + %w(readme.md Rakefile)
  s.require_paths = ["lib"]
  s.has_rdoc = false
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end