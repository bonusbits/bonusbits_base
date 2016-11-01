require 'spec_helper'

if rhel_family?
  if @setup_epel
    # Verify EPEL is setup
    describe 'EPEL Repo' do
      it 'Setup' do
        expect(file('/etc/yum.repos.d/epel.repo')).to exist
      end
    end
    if @install_software && @install_epel_packages
      # Verify EPEL Packages Installed if Enabled
      describe 'EPEL Installed Packages' do
        it 'Package Installed - htop' do
          expect(package('htop')).to be_installed
        end
      end
    end
  else
    # Verify EPEL is not setup
    describe 'EPEL Repo' do
      it 'Not Setup' do
        expect(file('/etc/yum.repos.d/epel.repo')).to_not exist
      end
    end
  end
end
