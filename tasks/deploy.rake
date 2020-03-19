# WIP
namespace :deploy do
  docker_name = @project_vars['docker_name']

  desc 'Deploy local'
  task :local do
    Rake::Task["docker:build_image"].execute
    Rake::Task["kubernetes:create_namespace"].execute
    Rake::Task["kubernetes:set_memory_limit"].execute
    # TODO: Rake::Task["kubernetes:deploy"].execute
  end

  desc 'Deploy to AWS using CloudFormation'
  task :cf_env do
    # TODO: Rake::Task["cloudformation:s3_upload"].execute
    # TODO: Rake::Task["cloudformation:launch"].execute
  end

  desc 'Deploy to AWS using Terraform'
  task :tf_env do
    Rake::Task["terraform:apply_var_file"].execute
  end
end
