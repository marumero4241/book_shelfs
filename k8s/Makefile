SHELL = /bin/bash

all:
	$(MAKE) kubectl-apply
	$(MAKE) kubectl-rollout-status
	$(MAKE) minikube-service

clean: kubectl-delete

kubectl-apply:
	kubectl create -f namespace
	kubectl apply -f config
	kubectl create secret generic secretland-secrets --from-literal=rails-master-key=$(cat ../config/master.key)
	kubectl apply -f volume
	kubectl apply -f setting

kubectl-rollout-status:
	kubectl rollout status deploy myapp-rails

minikube-service:
	minikube service myapp-rails -n=sample

kubectl-delete:
	kubectl -n sample delete deploy,pod,svc,PersistentVolume,PersistentVolumeClaim,secret --all         
	kubectl delete -f namespace      

