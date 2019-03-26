#!/bin/bash

docker build -t lashakitia/multi-client:latest -t lashakitia/mutli-client:$SHA -f ./client/Dockerfile ./client
docker build -t lashakitia/multi-server:latest -t lashakitia/mutli-server:$SHA -f ./server/Dockerfile ./server
docker build -t lashakitia/multi-worker:latest -t lashakitia/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lashakitia/multi-client:latest
docker push lashakitia/multi-server:latest
docker push lashakitia/multi-worker:latest

docker push lashakitia/mutli-client:$SHA
docker push lashakitia/mutli-server:$SHA
docker push lashakitia/mutli-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/client-deployment server=lashakitia/multi-client:$SHA
kubectl set image deployments/server-deployment server=lashakitia/multi-server:$SHA
kubectl set image deployments/worker-deployment server=lashakitia/multi-worker:$SHA
