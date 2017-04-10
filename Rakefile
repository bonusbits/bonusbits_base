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

  # Docker Test Suites
  desc 'kitchen - docker - tests'
  task :docker do
    load_kitchen_config('.kitchen.yml').instances.each do |instance|
      # puts "Instance Suite Name: (#{instance.suite.name})"
      next unless instance.suite.name =~ /^docker_.*/
      # puts 'It made it Next...'
      instance.test(:always)
    end
  end

  # EC2 Test Suites
  desc 'kitchen - ec2 - test'
  task :ec2 do
    load_kitchen_config('.kitchen.yml').instances.each do |instance|
      next unless instance.suite.name =~ /^ec2_.*/
      instance.test(:always)
    end
  end
end

desc 'Foodcritic, Rubocop & ChefSpec'
task default: %w(style:chef style:ruby)

desc 'Foodcritic & Rubocop'
task style_tasks: %w(style:chef style:ruby)

desc 'Circle CI Tasks'
task circleci: %w(style:chef style:ruby integration:docker)
# task circleci: %w(style:chef style:ruby)
