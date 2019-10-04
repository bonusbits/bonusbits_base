def load_project_vars
  require 'yaml'
  deploy_env = ENV.fetch('DEPLOY_ENV', 'local')
  @project_vars = YAML.load_file(File.join(__dir__, "../vars/#{deploy_env.downcase}.yml"))
end

def show_project_vars
  puts 'Project Variables'
  puts '------------------'
  @project_vars.each do |key, value|
    puts "#{key}: #{value}"
  end
end

def k8s_deployment_check_command(namespace, deployment_name)
  require 'open3'
  string_token_count = ENV['LOCAL_DEPLOY'] == 'true' ? '4' : '5'
  shell_command = "kubectl get deployments --namespace #{namespace} | grep #{deployment_name} | awk '{print $#{string_token_count}}'"
  out, err, status = Open3.capture3('/bin/bash', '-c', shell_command)
  successful = status.success?

  # Output Debug info if not Successful
  unless successful
    puts("Successful? (#{successful})")
    puts("Shell Command (#{shell_command})")
    puts("Status (#{status})")
    puts("Standard Out (#{out})")
    puts("Error Out (#{err})")
  end
  out.to_i
end

def k8s_deployment_check(namespace, deployment_name, replica_count)
  # Loop for 5 minutes and fail or Success
  count = 0
  rep_count = replica_count.to_i
  until deployment_check_command(namespace, deployment_name) == rep_count || count >= 60
    available_count = deployment_check_command(namespace, deployment_name)
    count += 1
    puts "INFO: Checking Deployment - Expected: (#{rep_count}) Current: (#{available_count}) LoopCount: (#{count})"
    sleep 5 unless available_count == rep_count
  end
  if deployment_check_command(namespace, deployment_name) == rep_count
    puts "INFO: Checking Deployment - Expected: (#{rep_count}) Current: (#{available_count})"
    puts 'INFO: Deployment Success!'
  else
    puts ''
    raise 'ERROR: Deployment Failed!'
  end
end
