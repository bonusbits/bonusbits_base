namespace :kubernetes do
  # Create Namespace if missing
  desc 'Create Kubernetes Namespace'
  task :create_namespace do
    sh 'kubectl get namespaces bonusbits || kubectl create -f kubernetes/namespace.yml'
  end

  # Set Memory Limit
  desc 'Set Kubernetes Container Memory Limit'
  task :set_memory_limit do
    sh 'kubectl apply -f kubernetes/memory-limit.yml --namespace=bonusbits'
  end

  # Deployment

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
end
