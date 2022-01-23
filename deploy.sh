docker build -t nur1kilcadir/multi-client:latest nur1kilcadir/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nur1kilcadir/multi-server:latest nur1kilcadir/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nur1kilcadir/multi-worker:latest nur1kilcadir/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nur1kilcadir/multi-client:latest
docker push nur1kilcadir/multi-server:latest
docker push nur1kilcadir/multi-worker:latest

docker push nur1kilcadir/multi-client:$SHA
docker push nur1kilcadir/multi-server:$SHA
docker push nur1kilcadir/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nur1kilcadir/multi-server:$SHA
kubectl set image deployments/client-deployment client=nur1kilcadir/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nur1kilcadir/multi-worker:$SHA