name 'bonusbits_base'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Foundation Wrapper Cookbook for all Nodes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.0'
source_url 'https://github.com/bonusbits/bonusbits_base'
issues_url 'https://github.com/bonusbits/bonusbits_base/issues'

depends 'bonusbits_library'
depends 'yum-epel'
depends 'apt'
depends 'firewall'
depends 'selinux'

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
