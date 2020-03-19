namespace :terraform do
  tf_var_file = @project_vars['tf_var_file']

  desc 'Deploy Environment Based on DEPLOY_ENV environment variable'
  task :apply_var_file do
    Rake::Task["terraform:init"].execute
    sh "terraform apply -var-file=#{tf_var_file} terraform/"
  end

  desc 'Deploy Environment Based on DEPLOY_ENV environment variable'
  task :plan_var_file do
    Rake::Task["terraform:init"].execute
    sh "terraform plan -var-file=#{tf_var_file} terraform/"
  end

  desc 'Deploy Environment Based on DEPLOY_ENV environment variable'
  task :init do
    sh 'terraform init terraform/'
  end

  desc 'Delete Environment Based on DEPLOY_ENV environment variable'
  task :destroy_var_file do
    sh "terraform destroy -var-file=#{tf_var_file} terraform/"
  end

  desc 'Load Terraform Console with Var File Based on DEPLOY_ENV environment variable'
  task :console do
    sh "terraform console -var-file=#{tf_var_file} terraform/"
  end
end
