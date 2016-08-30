source 'https://rubygems.org'

gem 'rake'
gem 'berkshelf', '>= 4.3'

group :lint do
  gem 'foodcritic', '>= 7.0.1'
  gem 'rubocop', '= 0.39.0'
  gem 'rainbow', '>= 2.1'
end

group :unit do
  gem 'chefspec', '>= 4.7'
  gem 'chef-sugar', '>= 3.4'
  gem 'fauxhai', '>= 3.8'
  gem 'coveralls', '>= 0.8.14'
end

group :integration do
  gem 'test-kitchen', '>= 1.11.1'
  gem 'inspec', '>= 0.15.0'
end

group :vagrant do
  gem 'kitchen-vagrant', '>= 0.20.0'
  gem 'vagrant-wrapper', '>= 2.0'
end

group :ec2 do
  gem 'kitchen-ec2', '>= 1.1.0'
end

group :docker do
  gem 'kitchen-docker', '~> 2.5'
end

group :windows do
  gem 'winrm-transport', '>= 1.0.3'
end
