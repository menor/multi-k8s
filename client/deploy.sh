docker build -t menor/multi-client:latest -t menor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t menor/multi-server:latest -t menor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t menor/multi-worker:latest -t menor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push menor/multi-client:latest
docker push menor/multi-server:latest
docker push menor/multi-worker:latest
docker push menor/multi-client:$SHA
docker push menor/multi-server:$SHA
docker push menor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=menor/multi-server:$SHA
kubectl set image deployments/client-deployment server=menor/multi-client:$SHA
kubectl set image deployments/worker-deployment server=menor/multi-worker:$SHA
