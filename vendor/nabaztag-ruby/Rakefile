require "rubygems"
require "rake/gempackagetask"
require "zlib"
require "rake/clean"

CLEAN.include("doc", "pkg")

SOURCES = FileList["lib/**/*.rb"]

spec = Gem::Specification.new do |s|
  s.name = "Nabaztag"
  s.version = "0.3.1"
  s.author = "Paul Battley"
  s.email = "paulbattley@reevoo.com"
  s.summary = "Nabaztag communication library for Ruby."
  s.files = SOURCES
  s.require_path = "lib"
  s.autorequire = "nabaztag"
  s.has_rdoc = true
  s.extra_rdoc_files = %w[README CHANGES]
  s.executables << "nabaztag-say"
end

task :default => :package

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar_gz = true
end

task :package => %W[
  pkg/#{spec.name}-#{spec.version}.gem
  pkg/#{spec.name}-#{spec.version}.tar.gz
] do
  puts "packaged version #{spec.version}"
end

file "doc" => SOURCES + spec.extra_rdoc_files do |t|
  p t.prerequisites
  rm_rf t.name
  sh "rdoc #{t.prerequisites.join(" ")}"
end

task :tag do
  unless (trunk = `svn info`[%r!URL: (.+/trunk)!, 1])
    raise RuntimeError, "Couldn't determine trunk URL"
  end
  tag = trunk.sub(/trunk$/, "tags/#{spec.name.downcase}-#{spec.version}")
  sh "svn cp #{trunk} #{tag} -m \"Automatically tagging version #{spec.version}\""
end