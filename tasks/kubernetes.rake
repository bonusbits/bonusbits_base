namespace :kubernetes do
  k8s_namespace = @project_vars['k8s_namespace']

  # Create Namespace if missing
  desc 'Create Kubernetes Namespace'
  task :create_namespace do
    sh "kubectl get namespaces #{k8s_namespace} > /dev/null 2>&1 || kubectl create namespace #{k8s_namespace}", verbose: false
  end

  # Set Memory Limit
  desc 'Set Kubernetes Container Memory Limit'
  task :set_memory_limit do
    rendered_template = render_erb_yml_template('kubernetes/memory-limit.yml')
    sh "kubectl apply -f #{rendered_template} --namespace=#{k8s_namespace}"
    # sh "kubectl apply -f kubernetes/memory-limit.yml --namespace=#{k8s_namespace}", verbose: false
  end

  # Deployment
  # desc 'Set Kubernetes Container Memory Limit'
  # task :generate_k8s_configs do
  #   Dir.glob('../kubernetes/*.yml').each do |template|
  #     render_k8s_template(template)
  #   end
  # end

  # Service

  # Check Deployment
  # define check_deployment
  #   $(call header,Checking $(UC_NAME) Deployment Availablity)
  #   @count=0; \
  #   until [ $$(kubectl get deployments --namespace $(NAMESPACE) | grep $(LC_NAME) | awk '{print $$4}' | tr -d '\n') == '1' ] || [ $$count -lt 60 ]; \
  #   do \
  #     let count+=1; \
  #     echo "INFO: Deployment NOT Running (Count: $$count)"; \
  #     sleep 5; \
  #   done
  #   @if [ $$(kubectl get deployments --namespace $(NAMESPACE) | grep $(LC_NAME) | awk '{print $$4}' | tr -d '\n') == '1' ]; then echo 'INFO: Deployment Success!'; else echo 'ERROR: Deployment Failure'; fi
  # endef

  # TODO: When gem released & matured, switch Shell commands to use SDK instead -=Levon 20191004
  # https://github.com/kubernetes-client/ruby
end

desc 'Deploy Docker Image to Kubernetes Cluster'
task k8s_deploy: %w[kubernetes:create_namespace kubernetes:set_memory_limit]
