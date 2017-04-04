default['bonusbits_base']['packages']['configure'] = true

default['bonusbits_base']['packages']['linux'].tap do |linux|
  linux['install_packages'] = true

  # EPEL Repos
  linux['epel']['configure'] = false
  linux['epel']['install_packages'] = false

  # Packages Lists
  linux['debian_packages'] = %w(
    awscli
    curl
    git
    gzip
    htop
    mlocate
    net-tools
    openssl
    procps
    sudo
    upstart
    util-linux
    vim
    which
  )

  linux['epel_packages'] = %w(
    htop
  )

  linux['redhat_packages'] = %w(
    ca-certificates
    curl
    git
    gzip
    mlocate
    net-tools
    openssh-clients
    openssh-server
    openssl
    procps
    sudo
    upstart
    util-linux-ng
    vim-enhanced
    which
  )

  linux['suse_packages'] = %w(
    awscli
    curl
    git
    gzip
    htop
    mlocate
    net-tools
    openssl
    procps
    sudo
    util-linux
    vim
    which
  )

  linux['windows_packages'] = %w(
    aws-cli
    powershell
    sysinternals
    git
  )

  linux['amazon_packages'] = %w(
    aws-cli
    ca-certificates
    curl
    git
    gzip
    htop
    mlocate
    net-tools
    openssh-clients
    openssh-server
    openssl
    procps
    sudo
    upstart
    util-linux
    vim-enhanced
    which
  )
end

# Debug
message_list = [
  '',
  '** Packages **',
  "INFO: Configure             (#{node['bonusbits_base']['packages']['configure']})",
  "INFO: Install Base Packages (#{node['bonusbits_base']['packages']['linux']['install_packages']})",
  "INFO: Configure EPEL        (#{node['bonusbits_base']['packages']['linux']['epel']['configure']})",
  "INFO: Install EPEL Packages (#{node['bonusbits_base']['packages']['linux']['epel']['install_packages']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
