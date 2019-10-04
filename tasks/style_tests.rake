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
        chef_version: '15.2.20',
        tags: %w(~FC001 ~FC019 ~FC016 ~FC039)
    }
  end
end

desc 'Style Tests (Foodcritic & Rubocop)'
task style_tests: %w(style:chef style:ruby)
