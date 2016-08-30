require 'spec_helper'

describe 'bonusbits_base::linux' do
  # fauxhai gem is used for OS Version Support. https://github.com/customink/fauxhai/tree/master/lib/fauxhai/platforms

  context 'Amazon' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'amazon', version: '2016.03')
      runner.converge(described_recipe)
    end

    it 'should install vim-enhanced, mlocate and wget' do
      expect(chef_run).to install_package(%w(vim-enhanced mlocate wget))
    end
    it 'should deploy nodeinfo script' do
      expect(chef_run).to create_template('/usr/bin/nodeinfo')
    end
  end

  context 'CentOS' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
      runner.converge(described_recipe)
    end

    it 'should install vim-enhanced, mlocate and wget' do
      expect(chef_run).to install_package(%w(vim-enhanced mlocate wget))
    end
    it 'should deploy nodeinfo script' do
      expect(chef_run).to create_template('/usr/bin/nodeinfo')
    end
  end

  context 'Redhat' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.1')
      runner.converge(described_recipe)
    end

    it 'should install vim-enhanced, mlocate and wget' do
      expect(chef_run).to install_package(%w(vim-enhanced mlocate wget))
    end
    it 'should deploy nodeinfo script' do
      expect(chef_run).to create_template('/usr/bin/nodeinfo')
    end
  end

  context 'Ubuntu' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'should include apt recipe' do
      expect(chef_run).to include_recipe('apt')
    end
    it 'should install vim-enhanced, mlocate and wget' do
      expect(chef_run).to install_package(%w(vim mlocate wget))
    end
    it 'should deploy nodeinfo script' do
      expect(chef_run).to create_template('/usr/bin/nodeinfo')
    end
  end
end
