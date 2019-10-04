# For CircleCI
# require 'bundler/setup'

Dir.glob('tasks/*.rake').each do |task_file|
  load task_file
end

desc 'Style Tests'
task default: %w(style:chef style:ruby:auto_correct)
