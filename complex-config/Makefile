update-kubeconfig-complex:
	aws eks --region us-east-1 update-kubeconfig --name bestir
	
update-kubeconfig-simple:
	aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)

# needs policy automation(after kubeconfig update) in the future
config-bestir-cluster:
	aws eks --region us-east-1 update-kubeconfig --name bestir
	
	kubectl apply -f k8s/public-lb.yaml 

	kubectl apply -f k8s/private-lb.yaml 

	kubectl apply -f k8s/cluster-autoscaler.yaml 


install-waypoint: 
	waypoint install --platform=kubernetes -accept-tos

watch-pods: 
	watch -n 1 -t kubectl get pods

