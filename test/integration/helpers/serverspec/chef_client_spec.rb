require 'spec_helper'

# Sometimes Organizations have different Versions of Chef Client Running between Linux and Windows
linux_chef_client_version = '12.13.37'
windows_chef_client_version = '12.13.37'

describe 'Chef Client Version' do
  if linux?
    it linux_chef_client_version do
      expect(command('knife -v').stdout).to contain(linux_chef_client_version)
    end
  end
  if windows?
    it windows_chef_client_version do
      expect(command('knife -v').stdout).to contain(windows_chef_client_version)
    end
  end
end
