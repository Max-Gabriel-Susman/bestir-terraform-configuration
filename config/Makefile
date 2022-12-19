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

	kubectl apply -f k8s/demo-deployment.yaml

create-id-ecr: 
	aws ecr create-repository --repository-name app-svc --region us-east-1

#{
#    "repository": {
#        "repositoryArn": "arn:aws:ecr:us-east-1:222267256875:repository/bestir-identity-service",
#        "registryId": "222267256875",
#        "repositoryName": "bestir-identity-service",
#        "repositoryUri": "222267256875.dkr.ecr.us-east-1.amazonaws.com/bestir-identity-service",
#        "createdAt": "2022-12-17T18:22:26-07:00",
#        "imageTagMutability": "MUTABLE",
#        "imageScanningConfiguration": {
#            "scanOnPush": false
#        },
#        "encryptionConfiguration": {
#            "encryptionType": "AES256"
#        }
#    }
#}

ecr-auth-docker: 
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 222267256875.dkr.ecr.us-east-1.amazonaws.com

ecr-tag-identity:
	docker tag 8154e16b2579 222267256875.dkr.ecr.region.amazonaws.com/identity-svc-ecr:latest

ecr-tag-application:
	docker tag a053712f152e 222267256875.dkr.ecr.region.amazonaws.com/application-svc-ecr:latest

push-identity:
	docker push 222267256875.dkr.ecr.region.amazonaws.com/identity-svc-ecr:latest

push-application:
	docker push a053712f152e 222267256875.dkr.ecr.region.amazonaws.com/application-svc-ecr:latest

install-waypoint: 
	waypoint install --platform=kubernetes -accept-tos

watch-pods: 
	watch -n 1 -t kubectl get pods


# okay, a cli will be nice longterm, but for now, let's just use make targets for this early stage dev shit
# I'm going to have to relearn how to parameterize these so we can include custom resource ids in the URIs of these requests

# probably just gonna make a bunch of parameterized curl commands for basic requests and then make some 
# more complex multi request make targets for handling larger operations, I'm not so sure I actually need 
# postman, pretty sure i can just do it all here, probably help me become a cURL ninja anyways`

get-accounts:
	curl -G 0.0.0.0:80/accounts

alt-post-account:
	curl -d '{"name":"prometheus", "-":"b"}' -X POST 0.0.0.0:80/account

post-account:
	curl --header "Content-Type: application/json" \
		--request POST \
		--data '{"name":"prometheus"}' \
		0.0.0.0:80/account

# curl -P 0.0.0.0:80/accounts 

# curl --header "Content-Type: application/json" \
#   --request POST \
#   --data '{"username":"xyz","password":"xyz"}' \
#   http://localhost:3000/api/login

create-account:
	echo "creating account"
	curl http://0.0.0.0:8080/accounts 
# curl --header "Content-Type: application/json" \
# 	--request POST \
# 	--data '{"name":"prometheus"}' \
# 	0.0.0.0:80/account

list-accounts:
	echo "getting account"
	curl http://localhost:8080/accounts 

put-account:
	echo "putting account"

patch-account:
	echo "patching account"

delete-account:
	echo "deleting account"

bestir-list-applications:
	echo "bestir listing applications"
	curl http://localhost:8081/application 

list-applications:
	echo "listing applications"
	curl http://localhost:8081/application 

run-identity:
	docker run -e DD_DISABLE=true \
		-e API_ADDRESS=0.0.0.0:8080 \
		-e IDENTITY_DB_USER=usr \
		-e IDENTITY_DB_PASSWORD=identity \
		-e IDENTITY_DB_HOST=127.0.0.1 \
		-e IDENTITY_DB_NAME=identity \
		-e IDENTITY_DB_PORT=3306 \
		-e ENABLE_MIGRATE=true bestir-identity-service
