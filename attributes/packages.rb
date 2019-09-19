default['bonusbits_base']['packages'].tap do |packages|
  packages['install'] = true
  packages['update'] = true

  # Packages Lists
  packages['amazon']['packages'] = %w(
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

  packages['debian']['packages'] = %w(
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

  packages['redhat']['packages'] = %w(
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

  packages['windows']['packages'] = %w(
    aws-cli
    powershell
    sysinternals
    git
  )
end

# Debug
message_list = [
  '',
  '** Packages **',
  "Install Base Packages       (#{node['bonusbits_base']['packages']['install']})",
  "Update System Packages      (#{node['bonusbits_base']['packages']['update']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
