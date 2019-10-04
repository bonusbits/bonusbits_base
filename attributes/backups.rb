default['bonusbits_base']['backups'].tap do |backups|
  backups['configure'] = false

  # Paths
  backups['local_tmp_path'] = '/tmp/backups'
  # Array of Paths to backup
  backups['backup_paths'] = %w[/etc /opt]
  backups['script_filename'] = 'backup_to_s3.rb'
  backups['script_fullname'] = "/usr/bin/#{node['bonusbits_base']['backups']['script_filename']}"
  script_fullname = node['bonusbits_base']['backups']['script_fullname']
  backups['cron_command'] =
    if ::File.exist?('/opt/chef/embedded/bin/ruby')
      "/opt/chef/embedded/bin/ruby #{script_fullname}"
    elsif ::File.exist?('/opt/chefdk/embedded/bin/ruby')
      "/opt/chefdk/embedded/bin/ruby #{script_fullname}"
    elsif ::File.exist?('/usr/bin/ruby')
      "/usr/bin/ruby #{script_fullname}"
    else
      raise 'ERROR: Ruby Path Not Found!'
    end

  # Filename
  backups['filename'] =
    if node['bonusbits_base']['deployment_type'] == 'ec2'
      "#{node['ec2']['instance_id']}-backup.tar.gz"
    else
      'backups.tar.gz'
    end

  # S3
  ## Recommended to turn on Versioning and add Lifecycle to bucket
  backups['s3_bucket_name'] = 'backup_bucket' # !! Required Override !!
  filename = node['bonusbits_base']['backups']['filename']
  env = run_state['detected_environment']
  s3_backup_bucket = node['bonusbits_base']['backups']['s3_bucket_name']
  backups['s3_full_path'] = "#{s3_backup_bucket}/backups/#{env}/#{filename}"

  # Cron
  ## Default is Daily at 11PM Server Time
  backups['minutes'] = '0'
  backups['hours'] = '23'
  backups['days'] = '*'
  backups['month'] = '*'
  backups['weekday'] = '*'

  # Backup Logs
  backups['configure_log_rotate'] = true
  backups['log_path'] = '/var/log/backups.log'
end

# Debug
message_list = [
  '',
  '** Backups **',
  "Configure                   (#{node['bonusbits_base']['backups']['configure']})",
  "Backup Filename             (#{node['bonusbits_base']['backups']['filename']})",
  "Script Filename             (#{node['bonusbits_base']['backups']['script_filename']})",
  "Script Fullname             (#{node['bonusbits_base']['backups']['script_fullname']})",
  "Local Temp Path             (#{node['bonusbits_base']['backups']['local_tmp_path']})",
  "S3 Full Path                (#{node['bonusbits_base']['backups']['s3_full_path']})",
  "Config Log Rotate           (#{node['bonusbits_base']['backups']['configure_log_rotate']})",
  "Log Path                    (#{node['bonusbits_base']['backups']['log_path']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
