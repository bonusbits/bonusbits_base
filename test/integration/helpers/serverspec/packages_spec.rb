require 'spec_helper'

rh_package_list = %w(vim-enhanced mlocate wget)
deb_package_list = %w(vim mlocate wget)

if linux?
  if @install_software
    describe 'Software Packages' do
      if rhel_family?
        it 'Installed' do
          rh_package_list.each do |package|
            expect(package(package)).to be_installed
          end
        end
      elsif debian? || ubuntu?
        it 'Installed' do
          deb_package_list.each do |package|
            expect(package(package)).to be_installed
          end
        end
      end
    end
  else
    describe 'Software Packages' do
      # Split out because wget is often installed by default.
      if rhel_family?
        it 'Not Installed' do
          expect(package('vim-enhanced')).to_not be_installed
          expect(package('mlocate')).to_not be_installed
        end
      elsif debian? || ubuntu?
        it 'Not Installed' do
          expect(package('htop')).to_not be_installed
          expect(package('vim')).to_not be_installed
          expect(package('mlocate')).to_not be_installed
        end
      end
    end
  end
end
