name 'bonusbits_base'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Foundation Wrapper Cookbook for all Nodes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '3.0.3'
chef_version '~> 15.4' if respond_to?(:chef_version)
source_url 'https://github.com/bonusbits/bonusbits_base'
issues_url 'https://github.com/bonusbits/bonusbits_base/issues'

depends 'apt'
depends 'selinux'
depends 'audit' # Allows Running InSpec as Part of Chef Run including Remote Profiles

%w[
  amazon
  debian
  ubuntu
  centos
  redhat
].each do |os|
  supports os
end
