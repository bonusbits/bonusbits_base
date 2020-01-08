namespace :docker do
  docker_name = @project_vars['docker_name']
  docker_repo = @project_vars['docker_repo']
  docker_tag = @project_vars['docker_tag']

  def docker_image_exist?(docker_repo, docker_name, docker_tag)
    run_command("docker image ls | grep -w #{docker_repo}/#{docker_name}:#{docker_tag}")
  end

  def docker_container_exist?(docker_repo, docker_name, docker_tag)
    run_command("docker container ls -a | grep -qw #{docker_repo}_#{docker_name}_#{docker_tag}")
  end

  desc 'Build Docker Image'
  task :build_image do
    sh "docker build -f Dockerfile -t #{docker_repo}/#{docker_name}:#{docker_tag} ."
  end

  desc 'List Docker Image'
  task :list_images do
    run_command_strout("docker image ls | grep '#{docker_repo}' || echo 'No Docker Images Found in Repo (#{docker_repo})'")
  end

  desc 'Create Container and Login from Docker Image'
  task :create_login do
    sh "docker run --name #{docker_repo}_#{docker_name}_#{docker_tag} -it #{docker_repo}/#{docker_name}:#{docker_tag} /bin/sh"
  end

  desc 'Login from Docker Container'
  task :login do
    if docker_container_exist?(docker_repo, docker_name, docker_tag)
      sh "docker container start #{docker_repo}_#{docker_name}_#{docker_tag} || echo 'INFO: Container Already Started'"
      sh "docker exec -it #{docker_repo}_#{docker_name}_#{docker_tag} /bin/sh"
    else
      sh "docker run --name #{docker_repo}_#{docker_name}_#{docker_tag} -it #{docker_repo}/#{docker_name}:#{docker_tag} /bin/sh"
    end
  end

  desc 'Build Docker Image'
  task :build_missing_image do
    if docker_image_exist?(docker_repo, docker_name, docker_tag)
      puts "INFO: Docker Image Already Exists (#{docker_repo}/#{docker_name}:#{docker_tag})"
    else
      sh "docker build -f Dockerfile -t #{docker_repo}/#{docker_name}:#{docker_tag} ."
    end
  end
end
