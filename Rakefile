require 'rake'
require 'rake/gempackagetask'
require 'fileutils'
include FileUtils

spec = Gem::Specification.new do |s|
    s.name = "smugrb"
    s.version = "0.0.1"
    s.author = "Sean Dague"
    s.email = "sean at dague dot net"
    s.homepage = "http://rubyforge.net/projects/smugrb"
    s.platform = Gem::Platform::RUBY
    s.summary = "Ruby interface for Smugmug API"
    s.files = FileList["{bin,lib}/**/*"].to_a
    s.require_path = "lib"
    s.autorequire = "smug"
    s.has_rdoc = true
    s.extra_rdoc_files = ["README"]
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = false
end

