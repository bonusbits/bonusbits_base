default['bonusbits_base']['proxy'].tap do |proxy|
  proxy['configure'] = false

  proxy['host'] = '10.0.2.2'
  proxy['port'] = '8888'

  proxy_host = node['bonusbits_base']['proxy']['host']
  proxy_port = node['bonusbits_base']['proxy']['port']
  proxy['url'] = "http://#{proxy_host}:#{proxy_port}"

  proxy['no_proxy'] = 'localhost'
  proxy['no_proxy'] += ',.localdomain.com'
  proxy['no_proxy'] += ',127.0.0.1'
  proxy['no_proxy'] += ',10.0.2.'
  proxy['no_proxy'] += ',/var/run/docker.sock'
  proxy['no_proxy'] += ',169.254.169.254'
  # proxy['no_proxy'] += ',s3.amazonaws.com' # TODO: Make more specific for VPCe or make optional?

  proxy_url = node['bonusbits_base']['proxy']['url']
  no_proxy = node['bonusbits_base']['proxy']['no_proxy']
  proxy['variables'] = <<-EOH
    ftp_proxy=#{proxy_url}
    http_proxy=#{proxy_url}
    https_proxy=#{proxy_url}
    no_proxy=#{no_proxy}
    FTP_PROXY=#{proxy_url}
    HTTPS_PROXY=#{proxy_url}
    HTTP_PROXY=#{proxy_url}
    NO_PROXY=#{no_proxy}
  EOH
end

# Debug
message_list = [
  '',
  '** Proxy **',
  "INFO: Configure             (#{node['bonusbits_base']['proxy']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
