# Integration Tests - Kitchen
namespace :integration do
  require 'kitchen'

  # Load Specific Kitchen Configuration YAML
  def load_kitchen_config(yaml)
    Kitchen.logger = Kitchen.default_file_logger
    kitchen_loader = Kitchen::Loader::YAML.new(local_config: yaml)
    Kitchen::Config.new(loader: kitchen_loader, log_level: :info)
  end

  # Docker Test Suites
  desc 'kitchen - docker - tests'
  task :docker do
    load_kitchen_config('.kitchen.yml').instances.each do |instance|
      next unless instance.suite.name =~ /^docker.*/

      instance.test(:always)
      puts "INFO: Instance Suite Name: (#{instance.suite.name})"
    end
  end

  # EC2 Test Suites
  desc 'kitchen - ec2 - test'
  task :ec2 do
    load_kitchen_config('.kitchen.yml').instances.each do |instance|
      next unless instance.suite.name =~ /^ec2.*/

      instance.test(:always)
      puts "INFO: Instance Suite Name: (#{instance.suite.name})"
    end
  end
end
