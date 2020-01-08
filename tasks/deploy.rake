# WIP
namespace :deploy do
  docker_name = @project_vars['docker_name']

  desc 'Deploy local'
  task :local do
    k8s_deploy
    sh "docker build -f Dockerfile -t #{docker_repo}/#{docker_name}:#{docker_tag} ."
  end
  desc 'Deploy to Dev'
  task :dev do
    # cloudformation:s3_upload
    sh 'aws-set-bbdev-public && cfnl-set-path $HOME/.cfnl/uswest2/home/bonusbits/dev/base'
    sh '/usr/local/bin/cfnl -s -f $HOME/.cfnl/uswest2/home/bonusbits/dev/base/base.yml'
  end
end
