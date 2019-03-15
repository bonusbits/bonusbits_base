# Package Lists
amazon1_packages = node['bonusbits_base']['packages']['amazon1']['packages']
amazon_packages = node['bonusbits_base']['packages']['amazon']['packages']
debian_packages = node['bonusbits_base']['packages']['debian']['packages']
redhat_packages = node['bonusbits_base']['packages']['redhat']['packages']
suse_packages = node['bonusbits_base']['packages']['suse']['packages']

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
  package debian_packages
when 'redhat', 'centos'
  package redhat_packages
when 'amazon'
  case node['platform_version']
  when '2'
    package amazon_packages
  when '1'
    package amazon1_packages
  end
when 'suse', 'opensuse'
  package suse_packages
else
  return
end
