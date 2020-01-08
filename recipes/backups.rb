case node['os']
when 'linux'
  # Deploy Backup Script
  template node['bonusbits_base']['backups']['script_fullname'] do
    source 'backups/backup_to_s3.rb.erb'
    owner 'root'
    group 'root'
    mode '0755'
  end

  # Create Cron Backup Job
  minutes = node['bonusbits_base']['backups']['minutes']
  hours = node['bonusbits_base']['backups']['hours']
  days = node['bonusbits_base']['backups']['days']
  month = node['bonusbits_base']['backups']['month']
  weekday = node['bonusbits_base']['backups']['weekday']

  cron 'Backups' do
    minute minutes
    hour hours
    day days
    month month
    weekday weekday
    user 'root'
    command node['bonusbits_base']['backups']['cron_command']
  end
end

# Deploy Logrotate Config
template '/etc/logrotate.d/backups' do
  mode '0755'
  owner 'root'
  group 'root'
  source 'backups/logrotate.erb'
  only_if { node['bonusbits_base']['backups']['configure_log_rotate'] }
end
