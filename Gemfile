source 'https://rubygems.org'

gem 'rake', '~> 11.3.0'
gem 'berkshelf', '~> 5.1.0'

group :lint do
  gem 'foodcritic', '~> 7.1.0'
  gem 'rubocop', '~> 0.39.0'
  gem 'rainbow', '~> 2.1.0'
end

group :unit do
  gem 'chefspec', '~> 5.2.0'
  gem 'chef-sugar', '~> 3.4.0'
  gem 'fauxhai', '~> 3.9.0'
  gem 'coveralls', '~> 0.8.0'
end

group :integration do
  gem 'test-kitchen', '~> 1.13.0'
  gem 'inspec', '~> 1.0'
end

group :vagrant do
  gem 'kitchen-vagrant', '~> 0.20.0'
end

group :ec2 do
  gem 'kitchen-ec2', '~> 1.0'
end

group :docker do
  gem 'kitchen-docker', '~> 2.0'
end
