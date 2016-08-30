require 'spec_helper'

base_iptables_rules = %w(
  -p tcp -m tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
  -m state --state RELATED,ESTABLISHED -j ACCEPT
  -i lo -j ACCEPT
  -p tcp -m tcp --dport 873 -m state --state NEW,ESTABLISHED -j ACCEPT
)

default_iptables_chains = %w(
  INPUT
  OUTPUT
  FORWARD
)

if linux? && !docker? && (redhat? || amazon?)
  if @config_firewall
    describe 'Iptables' do
      it 'Base Rules Configured (Drop In, Allow 22, lo, icmp, rsync)' do
        expect(iptables).to have_rule('DROP').with_chain('INPUT')
        base_iptables_rules.each do |rule|
          expect(iptables).to have_rule(rule).with_chain('INPUT')
        end
      end
    end
  else
    # Verify Default Iptables Configuration
    describe 'Iptables', if: redhat? || amazon? do
      it 'Not Configured' do
        default_iptables_chains.each do |chain|
          expect(iptables).to have_rule('ACCEPT').with_chain(chain)
        end
      end
    end
  end
end

if windows?
  # Place Holder
end
