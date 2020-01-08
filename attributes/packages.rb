default['bonusbits_base']['packages'].tap do |packages|
  packages['install'] = true
  packages['update'] = true

  # procps = ps, top, vmstat, kill, free, slabtop, and skill
  # util-linux = https://en.wikipedia.org/wiki/Util-linux ton of tools (i.e. fdisk, findfs, kill, last, lsblk, more, mount, su, and umount)
  # net-tools = arp, netstat, ifconfig, route, etc.

  # Packages Lists
  packages['amazon_linux1']['packages'] = %w[
    aws-cli
    ca-certificates
    curl
    git
    gzip
    htop
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
  ]

  packages['amazon_linux2']['packages'] = %w[
    awscli
    ca-certificates
    curl
    git
    gzip
    htop
    net-tools
    openssh-clients
    openssh-server
    openssl
    procps-ng
    sudo
    util-linux
    vim-enhanced
    which
  ]

  packages['ubuntu']['packages'] = %w[
    awscli
    bash-completion
    curl
    git
    gzip
    htop
    net-tools
    openssl
    procps
    sudo
    upstart
    util-linux
    vim
    wget
    which
  ]

  packages['redhat']['packages'] = %w[
    ca-certificates
    curl
    git
    gzip
    net-tools
    openssh-clients
    openssh-server
    openssl
    procps
    sudo
    upstart
    util-linux-ng
    vim-enhanced
    wget
    which
  ]
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
