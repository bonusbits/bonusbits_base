# Boolean return methods used in cookbook to reduced syntax to call node information

def amazon_linux?
  node['platform'] == 'amazon'
end

def aws?
  node['bonusbits_base']['deployment_location'] == 'aws'
end

def cloudformation?
  node['bonusbits_base']['deployment_method'] == 'cloudformation'
end

def dev?
  node['bonusbits_base']['deployment_environment'] == 'dev'
end

def docker?
  node['bonusbits_base']['deployment_type'] == 'docker'
end

def ec2?
  node['bonusbits_base']['deployment_type'] == 'ec2'
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
