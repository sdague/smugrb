#!/usr/bin/ruby
$: << File.expand_path(File.dirname(__FILE__) + "/lib")

require "smug"
require "yaml"
require "pp"
y = YAML.load_file("smug.yaml")
a = y["account"]

s = Smug::Session.new(a["key"], a["user"], a["passwd"])

s.albums_get()
