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

def load_project_vars
  require 'yaml'
  deploy_env = ENV.fetch('DEPLOY_ENV', 'local')
  @project_vars = YAML.load_file(File.join(__dir__, '../vars/shared.yml'))
  @project_vars = @project_vars.merge(YAML.load_file(File.join(__dir__, "../vars/#{deploy_env.downcase}.yml")))
end

def render_erb_yml_template(template)
  require 'erb'
  require 'yaml'
  require 'json'

  erb_template = ERB.new(File.read(template)).result
  YAML.safe_load(erb_template).to_json
  # rendered_service = YAML.safe_load(erb_template)
  # Write Rendered Config Data to file
  # File.open(template, 'w') { |file| file.write(rendered_service.to_yaml) }
end

def run_command(shell_command, _sensitive = false)
  # Will not show output until completed which sucks if want to watch the progress.
  require 'open3'
  _out, _err, status = Open3.capture3(shell_command)

  # successful = status.success?
  # unless successful
  #   puts('ERROR: Unsuccessful Command')
  #   puts("Open3: Shell Command (#{shell_command})") unless sensitive
  #   puts("Open3: Status (#{status})")
  #   puts("Open3: Standard Out (#{out})") unless sensitive
  #   puts("Open3: Successful? (#{successful})")
  #   puts("Open3: Error Out (#{err})") unless successful
  # end
  status.success?
end

def run_command_strout(shell_command, sensitive = false)
  # Will not show output until completed which sucks if want to watch the progress.
  require 'open3'
  out, err, status = Open3.capture3(shell_command)
  successful = status.success?
  unless successful
    puts('ERROR: Unsuccessful Command')
    puts("Open3: Shell Command (#{shell_command})") unless sensitive
    puts("Open3: Status (#{status})")
    puts("Open3: Standard Out (#{out})")
    puts("Open3: Successful? (#{successful})")
    puts("Open3: Error Out (#{err})")
  end
  puts out
end

def show_project_vars
  puts 'Project Variables'
  puts '------------------'
  @project_vars.each do |key, value|
    puts "#{key}: #{value}"
  end
end
