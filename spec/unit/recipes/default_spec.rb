require 'spec_helper'

describe 'bonusbits_base::default' do
  # fauxhai gem does not support the latest and great OS versions.
  # So the latest supported at the time are used.

  linux_platform_list = {
    Amazon: '2016.03',
    CentOS: '7.2.1511',
    Redhat: '7.1',
    Ubuntu: '16.04'
  }

  linux_platform_list.each do |platform, version|
    plat = platform.to_s
    context "#{plat} #{version}" do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(
          platform: plat.downcase,
          version: version
        )
        runner.converge(described_recipe)
      end

      it 'should include bonusbits_base::linux recipe' do
        expect(chef_run).to include_recipe('bonusbits_base::linux')
      end
    end
  end

  windows_platform_list = {
    Windows: '2012R2'
  }

  windows_platform_list.each do |platform, version|
    plat = platform.to_s
    context "#{plat} #{version}" do
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(
          platform: plat.downcase,
          version: version
        )
        runner.converge(described_recipe)
      end

      it 'should include bonusbits_base::windows recipe' do
        expect(chef_run).to include_recipe('bonusbits_base::windows')
      end
    end
  end
end
