default['bonusbits_base']['proxy'].tap do |proxy|
  proxy['configure'] = false

  proxy['host'] = '10.0.2.2'
  proxy['port'] = '8888'
  proxy['use_ssl'] = false
  run_state['proxy'] = Hash.new
  run_state['proxy']['user'] = nil
  run_state['proxy']['password'] = nil

  proxy_host = node['bonusbits_base']['proxy']['host']
  proxy_port = node['bonusbits_base']['proxy']['port']
  use_ssl = node['bonusbits_base']['proxy']['use_ssl']
  protocol = use_ssl ? 'https' : 'http'
  proxy_user = node.run_state['proxy']['user']
  proxy_password = node.run_state['proxy']['password']
  proxy['url'] =
    if proxy_user.nil?
      "#{protocol}://#{proxy_host}:#{proxy_port}"
    else
      "#{protocol}://#{proxy_user}:#{proxy_password}@#{proxy_host}:#{proxy_port}"
    end

  proxy['no_proxy'] = 'localhost'
  proxy['no_proxy'] += ',.localdomain.com'
  proxy['no_proxy'] += ',127.0.0.1'
  proxy['no_proxy'] += ',10.0.2.'
  proxy['no_proxy'] += ',/var/run/docker.sock'
  proxy['no_proxy'] += ',169.254.169.254'
  # proxy['no_proxy'] += ',s3.amazonaws.com' # TODO: Make more specific for VPCe or make optional?

  proxy_url = node['bonusbits_base']['proxy']['url']
  no_proxy = node['bonusbits_base']['proxy']['no_proxy']
  proxy['variables'] = <<-URLS
    ftp_proxy=#{proxy_url}
    http_proxy=#{proxy_url}
    https_proxy=#{proxy_url}
    no_proxy=#{no_proxy}
    FTP_PROXY=#{proxy_url}
    HTTPS_PROXY=#{proxy_url}
    HTTP_PROXY=#{proxy_url}
    NO_PROXY=#{no_proxy}
  URLS
end

# Debug
message_list = [
  '',
  '** Proxy **',
  "Configure                   (#{node['bonusbits_base']['proxy']['configure']})",
  "Host Address                (#{node['bonusbits_base']['proxy']['host']})",
  "Host Port                   (#{node['bonusbits_base']['proxy']['port']})",
  "Use SSL                     (#{node['bonusbits_base']['proxy']['use_ssl']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
