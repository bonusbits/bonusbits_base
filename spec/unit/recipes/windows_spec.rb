require 'spec_helper'

describe 'bonusbits_base::windows' do
  context 'Windows - Deploy NodeInfo Script' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    it 'should deploy nodeinfo script' do
      expect(chef_run).to create_template('C:/Windows/System32/nodeinfo.cmd')
    end
  end
end
