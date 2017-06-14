case node['os']
when 'linux'
  case node['platform']
  when 'amazon'
    package_list = %w(perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https)
  when 'centos', 'redhat' # ~FC024
    package_list = %w(perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA zip unzip)
  when 'ubuntu', 'debian'
    package_list = %w(unzip libwww-perl libdatetime-perl)
  else
    return
  end
  # Install Dependant Packages
  package package_list

  # Download Monitoring Scripts
  scripts_url = node['bonusbits_base']['cloudwatch']['scripts_url']
  local_path = node['bonusbits_base']['cloudwatch']['zip_fullname']
  remote_file local_path do
    source scripts_url
  end

  # Extract Monitoring Scripts
  ruby_block 'Extract Monitoring Scripts' do
    block do
      shell_command = "unzip #{local_path} -d /opt"
      successful = BonusBits::Shell.run_command(shell_command)
      raise 'ERROR: Failed to Extract Monitoring Scripts!' unless successful
    end
    not_if { ::File.directory?('/opt/aws-scripts-mon') }
  end

  cron_command = node['bonusbits_base']['cloudwatch']['cron_command']
  cron 'Create Cloudwatch Monitoring Cron' do
    minute '*/5'
    hour '*'
    day '*'
    month '*'
    weekday '*'
    user 'root'
    command cron_command
  end
when 'windows'
  return
else
  return
end
