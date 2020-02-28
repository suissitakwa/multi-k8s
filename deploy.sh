docker build -t suissitakwa/multi-client:latest -t suissitakwa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t suissitakwa/multi-server:latest -t suissitakwa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t suissitakwa/multi-worker:latest -t suissitakwa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push suissitakwa/multi-client:latest
docker push suissitakwa/multi-server:latest
docker push suissitakwa/multi-worker:latest

docker push suissitakwa/multi-client:$SHA
docker push suissitakwa/multi-server:$SHA
docker push suissitakwa/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=suissitakwa/multi-server:$SHA
kubectl set image deployments/client-deployment client=suissitakwa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=suissitakwa/multi-worker:$SHA