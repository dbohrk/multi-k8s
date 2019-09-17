docker build -t dbohrk/multi-client:latest -t dbohrk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dbohrk/multi-server:latest -t dbohrk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dbohrk/multi-worker:latest -t dbohrk/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dbohrk/multi-client:latest
docker push dbohrk/multi-client:$SHA
docker push dbohrk/multi-server:latest
docker push dbohrk/multi-server:$SHA
docker push dbohrk/multi-worker:latest
docker push dbohrk/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dbohrk/multi-server:$SHA
kubectl set image deployments/client-deployment client=dbohrk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dbohrk/multi-worker:$SHA
