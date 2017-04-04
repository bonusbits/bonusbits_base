case node['os']
when 'linux'
  # Configure Firewall
  firewall 'default' do
    action :install
  end

  firewall_rules = node['bonusbits_base']['firewall']['iptables']['rules']
  unless firewall_rules.empty?
    firewall_rules.each do |rule, raw_parameters|
      firewall_rule rule do
        raw raw_parameters
      end
    end
  end
when 'windows'
  return
else
  return
end
