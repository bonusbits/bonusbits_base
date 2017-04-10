name 'bonusbits_base'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Foundation Wrapper Cookbook for all Nodes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.1.3'
source_url 'https://github.com/bonusbits/bonusbits_base'
issues_url 'https://github.com/bonusbits/bonusbits_base/issues'

depends 'bonusbits_library'
depends 'yum-epel'
depends 'apt'
depends 'selinux'
depends 'audit' # Allows Running InSpec as Part of Chef Run including Remote Profiles

%w(
  amazon
  debian
  ubuntu
  centos
  redhat
  suse
  opensuse
  windows
).each do |os|
  supports os
end
