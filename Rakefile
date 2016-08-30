# For CircleCI
require 'bundler/setup'

# Style tests. Rubocop and Foodcritic
namespace :lint do
  require 'rubocop/rake_task'
  require 'foodcritic'
  desc 'RuboCop'
  RuboCop::RakeTask.new(:ruby)

  desc 'FoodCritic'
  FoodCritic::Rake::LintTask.new(:chef) do |task|
    task.options = {
      fail_tags: ['correctness'],
      chef_version: '12.13.37',
      tags: %w(~FC001 ~FC019)
    }
  end
end

# Rspec and ChefSpec
namespace :unit do
  require 'coveralls/rake/task'
  require 'rspec/core/rake_task'
  desc 'Unit Tests (Rspec & ChefSpec)'
  RSpec::Core::RakeTask.new(:rspec)
end

# Integration Tests - Kitchen
namespace :integration do
  require 'kitchen'

  # Load Specific Kitchen Configuration YAML
  # (run_kitchen + kitchen_list Sub-Method)
  def load_kitchen_config(driver)
    Kitchen.logger = Kitchen.default_file_logger
    kitchen_loader =
      if driver == 'vagrant'
        Kitchen::Loader::YAML.new(local_config: '.kitchen.yml')
      else
        Kitchen::Loader::YAML.new(local_config: ".kitchen.#{driver}.yml")
      end
    Kitchen::Config.new(loader: kitchen_loader, log_level: :info)
  end

  # Execute Specified Kitchen Command on a Single Test Instance
  @command_list = %w(converge test verify destroy)
  def exec_kitchen(instance, kitchen_command, driver, filter)
    kitchen_header(driver, filter, kitchen_command)
    case kitchen_command
    when 'test'
      instance.test(:always)
    when 'converge'
      instance.converge
    when 'verify'
      instance.verify
    when 'destroy'
      instance.destroy
    else
      instance.test(:always)
    end
  end

  # Get Test Suite Names for a Particular Driver
  def test_suites(driver, filter_list, exclude_list)
    load_kitchen_config(driver).suites.as_names.each do |test_suite|
      filter_list << test_suite unless exclude_list.include?(test_suite)
    end
    filter_list
  end

  def output_kitchen_config_name(driver)
    puts ''
    puts 'Kitchen Config'
    puts '---------------------------------'
    puts ">> .kitchen.#{driver}.yml <<" unless driver == 'vagrant'
    puts '>> (.kitchen.yml) <<' if driver == 'vagrant'
  end

  def output_test_suites(driver)
    puts ''
    puts 'Test Suites'
    puts '---------------------------------'
    count = 1
    load_kitchen_config(driver).suites.as_names.each do |test_suite|
      puts "#{count}.  #{test_suite}"
      count += 1
    end
  end

  def output_test_instance(driver)
    puts ''
    puts 'Test Instances'
    puts '---------------------------------'
    count = 1
    load_kitchen_config(driver).instances.each do |instance|
      puts "#{count}.  #{instance.name}"
      count += 1
    end
  end

  def output_filter_options(filter_list)
    puts ''
    puts 'Filter Options'
    puts '---------------------------------'
    count = 1
    filter_list.each do |filter|
      puts "#{count}.  #{filter}"
      count += 1
    end
  end

  # Display List of Test Instances for a Specific Driver
  ## Task inside method for auto generating Rake Tasks for Each Driver
  def kitchen_list(driver, filter_list)
    desc "kitchen - #{driver} - list"
    task :list do
      output_kitchen_config_name(driver)
      output_filter_options(filter_list)
      output_test_instance(driver)
      puts ''
    end
  end

  def kitchen_header(driver, filter, kitchen_command)
    header = [
      '',
      'Test Kitchen Integration Testing',
      '---------------------------------',
      "DRIVER:           #{driver}",
      "INSTANCE FILTER:  #{filter}",
      "KITCHEN COMMAND:  #{kitchen_command}"
    ]

    header.each do |value|
      puts value
    end

    Rake::Task["integration:#{driver}:list"].invoke
  end

  # Determine if Linux
  def match_all?(filter)
    filter == 'all'
  end

  # Determine if Linux
  def match_linux?(instance_name, filter)
    filter == 'linux' && instance_name =~ /amazon|centos|rhel|ubuntu|suse/
  end

  # Determine if Windows
  def match_windows?(instance_name, filter)
    filter == 'windows' && instance_name =~ /win/
  end

  # Determine if Windows
  def other_match?(instance_name, filter)
    instance_name =~ /#{filter}/
  end

  # Compare Test Instance Name to Filter for Match. This allows selecting which Test Instances to Run.
  def filter_instance(instance_name, filter)
    puts "ACTION: Filtering Instance Name (#{instance_name}) Against (#{filter})"
    results = match_all?(filter) ||
              match_linux?(instance_name, filter) ||
              match_windows?(instance_name, filter) ||
              other_match?(instance_name, filter)
    if results
      puts 'REPORT: Instance Filter Matches'
    else
      puts 'REPORT: Test Instance was Filtered Out and Ignored'
    end
    results
  end

  # Run Kitchen Command on Specific Driver (Vagrant, Docker, EC2) and Test Suites
  def run_kitchen(driver, filter_list, exclude_list)
    test_suites(driver, filter_list, exclude_list).each do |filter|
      namespace filter.to_s do
        @command_list.each do |kitchen_command|
          desc "kitchen - #{driver} - #{filter} - #{kitchen_command}"
          task kitchen_command.to_s do
            load_kitchen_config(driver).instances.each do |instance|
              exec_kitchen(instance, kitchen_command, driver, filter) if filter_instance(instance.name, filter)
            end
          end
        end
      end
    end
  end

  namespace :docker do
    docker_filter_list = %w(all centos centos-6 centos-7 ubuntu ubuntu-14 ubuntu-16)
    driver = 'docker'
    exclude_list = %w(proxy)
    kitchen_list(driver, docker_filter_list)
    run_kitchen(driver, docker_filter_list, exclude_list)
  end

  namespace :vagrant do
    vagrant_filter_list = %w(all centos centos-6 centos-7 ubuntu ubuntu-14 ubuntu-16)
    driver = 'vagrant'
    exclude_list = []
    kitchen_list(driver, vagrant_filter_list)
    run_kitchen(driver, vagrant_filter_list, exclude_list)
  end

  namespace :ec2 do
    ec2_filter_list = %w(all linux windows rhel rhel-6 rhel-7 ubuntu ubuntu-14 ubuntu-16 windows-2012r2)
    driver = 'ec2'
    exclude_list = %w(proxy)
    kitchen_list(driver, ec2_filter_list)
    run_kitchen(driver, ec2_filter_list, exclude_list)
  end
end

desc 'Travis CI Tasks'
task travisci: %w(unit:rspec lint:chef lint:ruby)

desc 'Circle CI Tasks'
# Have to Skip Proxy Configuration because won't work in CircleCI
# task circleci: %w(
#   unit:rspec
#   lint:chef
#   lint:ruby
#   integration:docker:base:test
#   integration:docker:base_epel_repo:test
#   integration:docker:base_no_software:test
# )
task circleci: %w(lint:chef lint:ruby unit:rspec integration:docker:test)

desc 'Foodcritic, Rubocop & ChefSpec'
task default: %w(lint:chef lint:ruby unit:rspec)
