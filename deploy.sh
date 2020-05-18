docker build -t leslielees/k8-frontend:latest -t leslielees/k8-frontend:$SHA -f ./client/Dockerfile ./client
docker build -t leslielees/k8-api:latest -t leslielees/k8-api:$SHA -f ./server/Dockerfile ./server
docker build -t leslielees/k8-worker:latest -t leslielees/k8-worker:$SHA -f ./worker/Dockerfile ./worker

docker push leslielees/k8-frontend:latest
docker push leslielees/k8-api:latest
docker push leslielees/k8-worker:latest

docker push leslielees/k8-frontend:$SHA
docker push leslielees/k8-api:$SHA
docker push leslielees/k8-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=leslielees/k8-api:$SHA
kubectl set image deployments/client-deployment client=leslielees/k8-frontend:$SHA
kubectl set image deployments/worker-deployment worker=leslielees/k8-worker:$SHA