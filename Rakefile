# For CircleCI
# require 'bundler/setup'

# Load Rake Task Helper Methods
require_relative 'tasks/helpers'

# Load Project Variables
load_project_vars

desc 'Show Project Variables from YAML'
task :show_project_vars do
  show_project_vars
end

Dir.glob('tasks/*.rake').each do |task_file|
  load task_file
end

desc 'Style Tests'
task default: %w[style:chef style:ruby:auto_correct]
