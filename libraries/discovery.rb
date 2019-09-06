module BonusBits
  # Discovery Class
  class Discovery
    def self.ec2?(fqdn, platform_family)
      return true if fqdn =~ /^ip-.*\.compute\.internal$/
      case platform_family
      when 'rhel'
        ec2_net_script = '/etc/sysconfig/network-scripts/ec2net-functions'
        ec2_user = '/home/ec2-user'
        ::File.directory?(ec2_user) && ::File.exist?(ec2_net_script)
      when 'windows'
        ::File.directory?('C:/Users/ec2-user')
      else
        false
      end
    end

    def self.aws?(fqdn, platform_family)
      return true if ec2?(fqdn, platform_family)
      # TODO: Need more magic for ECS Docker container
    end
  end
end
