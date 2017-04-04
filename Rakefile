# For CircleCI
require 'bundler/setup'

# Style tests. Rubocop and Foodcritic
namespace :style do
  require 'rubocop/rake_task'
  require 'foodcritic'
  desc 'RuboCop'
  RuboCop::RakeTask.new(:ruby)

  desc 'FoodCritic'
  FoodCritic::Rake::LintTask.new(:chef) do |task|
    task.options = {
      fail_tags: ['correctness'],
      chef_version: '12.18.31',
      tags: %w(~FC001 ~FC019 ~FC016 ~FC039)
    }
  end
end

# Rspec and ChefSpec
namespace :unit do
  desc 'Unit Tests (Rspec & ChefSpec)'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:rspec)

  desc 'Unit Tests for CircleCI'
  RSpec::Core::RakeTask.new(:circleci_rspec) do |test|
    # t.fail_on_error = false
    test.rspec_opts =
      '--no-drb -r rspec_junit_formatter --format RspecJunitFormatter -o $CIRCLE_TEST_REPORTS/rspec/junit.xml'
  end
end

# Integration Tests - Kitchen
namespace :integration do
  require 'kitchen'

  # Load Specific Kitchen Configuration YAML
  def load_kitchen_config(yaml)
    Kitchen.logger = Kitchen.default_file_logger
    kitchen_loader = Kitchen::Loader::YAML.new(local_config: yaml)
    Kitchen::Config.new(loader: kitchen_loader, log_level: :info)
  end

  # Run Each Test Instance in All Test Suites from YAML
  desc 'kitchen - docker - test'
  task :docker do
    load_kitchen_config('.kitchen.docker.yml').instances.each do |instance|
      instance.test(:always)
    end
  end

  # Run Each Test Instance in All Test Suites from YAML
  desc 'kitchen - ec2 - test'
  task :ec2 do
    load_kitchen_config('.kitchen.yml').instances.each do |instance|
      instance.test(:always)
    end
  end

  # Run Each Test Instance in All Test Suites from YAML
  desc 'kitchen - vagrant - test'
  task :vagrant do
    load_kitchen_config('.kitchen.vagrant.yml').instances.each do |instance|
      instance.test(:always)
    end
  end
end

desc 'Foodcritic, Rubocop & ChefSpec'
task default: %w(style:chef style:ruby)

desc 'Foodcritic & Rubocop'
task style_only: %w(style:chef style:ruby)

desc 'Circle CI Tasks'
# task circleci: %w(style:chef style:ruby integration:docker)
task circleci: %w(style:chef style:ruby)

desc 'Foodcritic, Rubocop, ChefSpec and Docker Integration Tests'
task docker_ci: %w(style:chef style:rubyintegration:docker)

desc 'Foodcritic, Rubocop, ChefSpec and EC2 Integration Tests'
task ec2_ci: %w(style:chef style:ruby integration:ec2)

desc 'Foodcritic, Rubocop, ChefSpec and VagrantIntegration Tests'
task vagrant_ci: %w(style:chef style:ruby integration:vagrant)
