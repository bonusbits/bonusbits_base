namespace :undeploy do
  desc 'Delete Environment Based on DEPLOY_ENV environment variable'
  task :tf_env do
    Rake::Task["terraform:destroy_var_file"].execute
  end
end
