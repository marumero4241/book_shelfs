SHELL = /bin/bash

all:
	$(MAKE) kubectl-apply
	$(MAKE) kubectl-rollout-status
	$(MAKE) minikube-service

clean: kubectl-delete

kubectl-apply:
	kubectl create -f namespace
	kubectl apply -f config
	kubectl apply -f volumes
	kubectl apply -f settings

kubectl-rollout-status:
	kubectl rollout status deploy myapp-rails

minikube-service:
	minikube service myapp-rails


kubectl-delete:
	cat */*.yaml | kubectl delete -f -

