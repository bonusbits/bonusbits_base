require 'aws-sdk'

def amazon_linux?
  node['platform'] == 'amazon'
end

def aws?
  # TODO: Need more magic for ECS Docker container
  ec2?
end

def cloudformation?
  node['bonusbits_base']['deployment_method'] == 'cloudformation'
end

def dev?
  node['bonusbits_base']['deployment_environment'] == 'dev'
end

def docker?
  File.exist?('/.dockerenv')
end

def ec2?
  fqdn = node['fqdn']
  return true if fqdn =~ /^ip-.*\.compute\.internal$/
  case node['platform_family']
  when 'rhel'
    ec2_user = '/home/ec2-user'
    ec2_net_script = '/etc/sysconfig/network-scripts/ec2net-functions'
    ::File.directory?(ec2_user) || ::File.exist?(ec2_net_script)
  when 'windows'
    ::File.directory?('C:/Users/ec2-user')
  else
    false
  end
end

def kitchen?
  node['bonusbits_base']['deployment_method'] == 'kitchen'
end

def linux?
  node['os'] == 'linux'
end

def prod?
  node['bonusbits_base']['deployment_environment'] == 'prod'
end

def pod?
  File.exisit?('')
end

def qa?
  node['bonusbits_base']['deployment_environment'] == 'qa'
end

def redhat?
  node['platform'] == 'redhat'
end

def terraform?
  node['bonusbits_base']['deployment_method'] == 'terraform'
end

def windows?
  node['os'] == 'windows'
end
