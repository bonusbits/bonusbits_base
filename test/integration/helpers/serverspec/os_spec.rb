require 'spec_helper'

# This is mostly just for example of parsing a file
describe 'OS' do
  if linux?
    if redhat?
      if rhel6?
        it 'Enterprise Linux Server 6' do
          expect(file('/etc/redhat-release').content).to match(/release 6/)
        end
      elsif rhel7?
        it 'Enterprise Linux Server 7' do
          expect(file('/etc/redhat-release').content).to match(/release 7/)
        end
      end
    elsif ubuntu?
      if ubuntu1404?
        it 'Ubuntu 14.04' do
          expect(file('/etc/os-release').content).to match(/VERSION_ID="14\.04"/)
        end
      elsif ubuntu1604?
        it 'Ubuntu 16.04' do
          expect(file('/etc/os-release').content).to match(/VERSION_ID="16\.04"/)
        end
      end
    end
  elsif windows?
    # Place Holder
  end
end
