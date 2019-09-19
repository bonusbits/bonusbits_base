namespace :docker do
  require 'open3'
  desc 'Build Docker Image'
  task :build_image do
    sh 'docker build -f Dockerfile -t bonusbits/base:latest .'
  end
end
