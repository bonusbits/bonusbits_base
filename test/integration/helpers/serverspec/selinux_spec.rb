require 'spec_helper'

unless docker?
  if redhat?
    describe 'SELinux' do
      it 'Disabled' do
        expect(file('/etc/selinux/config').content).to match(/SELINUX=disabled/)
      end
    end
  end
end
