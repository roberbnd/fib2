docker build -t roberbnd/multi-client:latest -t  roberbnd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t roberbnd/multi-server:latest -f  roberbnd/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t roberbnd/multi-worker:latest -f  roberbnd/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push roberbnd/multi-client:latest
docker push roberbnd/multi-server:latest
docker push roberbnd/multi-worker:latest

docker push roberbnd/multi-client:$SHA
docker push roberbnd/multi-sever:$SHA
docker push roberbnd/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=roberbnd/multi-client:$SHA
kubectl set image deployments/server-deployment server=roberbnd/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=roberbnd/multi-worker:$SHA