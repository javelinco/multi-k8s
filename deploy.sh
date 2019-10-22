docker build -t mmunson/multi-client:latest  -t mmunson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mmunson/multi-server:latest  -t mmunson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mmunson/multi-worker:latest -t mmunson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mmunson/multi-client:latest
docker push mmunson/multi-server:latest
docker push mmunson/multi-worker:latest

docker push mmunson/multi-client:$SHA
docker push mmunson/multi-server:$SHA
docker push mmunson/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=mmunson/multi-client:$SHA
kubectl set image deployments/server-deployment server=mmunson/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mmunson/multi-worker:$SHA