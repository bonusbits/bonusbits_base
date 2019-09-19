# For CircleCI
# require 'bundler/setup'

Dir.glob('tasks/*.rake').each do |task_file|
  load task_file
end

desc 'Style Tests (Foodcritic & Rubocop)'
task style_tests: %w(style:chef style:ruby)

desc 'Integration Tests (Test Kitchen)'
task integration_tests: %w(integration:docker)
