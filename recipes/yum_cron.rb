case node['os']
when 'linux'
  case node['platform']
  when 'amazon'
    # Install Yum Cron
    package 'yum-cron'

    # Deploy Yum Cron Config
    template '/etc/yum/yum-cron.conf' do
      source 'yum_cron/yum-cron.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      notifies :restart, 'service[yum-cron]', :delayed
    end

    # Deploy Yum Cron Config
    template '/etc/yum/yum-cron-hourly.conf' do
      source 'yum_cron/yum-cron-hourly.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      notifies :restart, 'service[yum-cron]', :delayed
    end

    # Enable and Start Service
    service 'yum-cron' do
      action [:enable, :start]
    end
  else
    return
  end
when 'windows'
  return
else
  return
end
