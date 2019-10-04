case node['platform']
when 'amazon'
  # Install Update Message of the Day Package
  package %w[update-motd lolcat]

  # '/etc/cron.d/update-motd'
  # 'root /sbin/start --quiet update-motd'
  # /etc/init/update-motd.conf = 'exec /usr/sbin/update-motd'

  # Deploy System Profile
  template '/etc/profile' do
    source 'bash_profile/profile.sh.erb'
    owner 'root'
    group 'root'
    mode '0644'
    only_if { node['bonusbits_base']['deployment_type'] == 'docker' }
  end

  # Deploy MOTD Banner
  template '/etc/update-motd.d/30-banner' do
    source 'bash_profile/30-banner.sh.erb'
    owner 'root'
    group 'root'
    mode '0755'
    sensitive true
  end

  # Deploy Bonusbits Profile
  template '/etc/profile.d/bonusbits_profile.sh' do
    source 'bash_profile/bonusbits_profile.sh.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end

  # Deploy Bonusbits Ascii Banner Art
  template '/var/lib/update-motd/bonusbits_banner' do
    source 'bash_profile/bonusbits_banner.txt.erb'
    owner 'root'
    group 'root'
    mode '0644'
    sensitive true
  end

  # Refresh MOTD
  execute '/usr/sbin/update-motd --force'
else
  return
end
