# Package Lists
amazon_linux1_packages = node['bonusbits_base']['packages']['amazon_linux1']['packages']
amazon_linux2_packages = node['bonusbits_base']['packages']['amazon_linux2']['packages']
ubuntu_packages = node['bonusbits_base']['packages']['ubuntu']['packages']
redhat_packages = node['bonusbits_base']['packages']['redhat']['packages']

if node['bonusbits_base']['packages']['update']
  # Update System Packages
  case node['platform']
  # Install Software Packages
  when 'debian', 'ubuntu'
    execute 'apt-get update && apt-get -y upgrade --exclude=kernel*'
  when 'redhat', 'centos'
    execute 'yum update -y --exclude=kernel*'
  when 'amazon'
    execute 'yum update -y --exclude=kernel*'
  else
    return
  end
end

# Install Software Packages
case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'apt'
  package ubuntu_packages
when 'redhat', 'centos'
  package redhat_packages
when 'amazon'
  package amazon_linux2? ? amazon_linux2_packages : amazon_linux1_packages
else
  return
end
