#!/bin/bash

docker build -t lashakitia/multi-client:latest -t lashakitia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lashakitia/multi-server:latest -t lashakitia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lashakitia/multi-worker:latest -t lashakitia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lashakiita/multi-client:latest
docker push lashakiita/multi-server:latest
docker push lashakiita/multi-worker:latest

docker push lashakitia/multi-client:$SHA
docker push lashakitia/multi-server:$SHA
docker push lashakitia/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/client-deployment client=lashakitia/multi-client:$SHA
kubectl set image deployments/server-deployment server=lashakitia/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lashakitia/multi-worker:$SHA
