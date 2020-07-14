docker build -t alexguerreiro85/multi-client:latest -t alexguerreiro85/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexguerreiro85/multi-server:latest -t alexguerreiro85/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexguerreiro85/multi-worker:latest -t alexguerreiro85/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexguerreiro85/multi-client:latest
docker push alexguerreiro85/multi-server:latest
docker push alexguerreiro85/multi-worker:latest

docker push alexguerreiro85/multi-client:$SHA
docker push alexguerreiro85/multi-server:$SHA
docker push alexguerreiro85/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexguerreiro85/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexguerreiro85/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexguerreiro85/multi-worker:$SHA
