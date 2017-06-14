default['bonusbits_base']['cloudwatch'].tap do |cloudwatch|
  cloudwatch['configure'] = false

  # Monitoring Scripts (AWS Examples Default)
  cloudwatch['zip_filename'] = 'CloudWatchMonitoringScripts-1.2.1.zip'
  zip_filename = node['bonusbits_base']['cloudwatch']['zip_filename']
  cloudwatch['scripts_url'] =
    "http://aws-cloudwatch.s3.amazonaws.com/downloads/#{zip_filename}"
  cloudwatch['zip_fullname'] = "#{node['bonusbits_base']['local_file_cache']}/#{zip_filename}"

  # Cron
  cloudwatch['cron_command'] = '/opt/aws-scripts-mon/mon-put-instance-data.pl'
  cloudwatch['cron_command'] += ' --mem-util --mem-used'
  cloudwatch['cron_command'] += ' --mem-avail --disk-space-util'
  cloudwatch['cron_command'] += ' --disk-path=/ --from-cron'
end

# Debug
message_list = [
  '',
  '** CloudWatch Monitoring **',
  "Configure                   (#{node['bonusbits_base']['cloudwatch']['configure']})",
  "Zip Filename                (#{node['bonusbits_base']['cloudwatch']['zip_filename']})",
  "Zip Fullname                (#{node['bonusbits_base']['cloudwatch']['zip_fullname']})",
  "Scripts URL                 (#{node['bonusbits_base']['cloudwatch']['scripts_url']})",
  "Cron Command                (#{node['bonusbits_base']['cloudwatch']['cron_command']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
