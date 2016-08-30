if ENV['CI'] && (!defined?(RUBY_ENGINE) || RUBY_ENGINE == 'ruby')
  require 'coveralls'
  Coveralls.wear!
end

# Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |file| require file }

require 'chefspec'
require 'chefspec/berkshelf'

at_exit { ChefSpec::Coverage.report! }
