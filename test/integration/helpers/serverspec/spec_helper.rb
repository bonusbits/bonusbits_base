# Encoding: utf-8
require 'serverspec'
require_relative 'helpers'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
  set :path, '/sbin:/usr/local/sbin:/bin:/usr/bin:$PATH'
else
  set :backend, :cmd
  set :os, family: 'windows'
end

puts "REPORT: ServerSpec OS FAMILY: (#{os[:family]})"
