Write-Host "=== Building Docker images for Spring PetClinic microservices ==="

# Contexte de build : la racine du projet, qui contient le parent pom.xml
docker build -f .\docker\Dockerfile.customers-service -t customers-service .
docker build -f .\docker\Dockerfile.vets-service -t vets-service .
docker build -f .\docker\Dockerfile.visits-service -t visits-service .
docker build -f .\docker\Dockerfile.api-gateway -t api-gateway .

Write-Host "`n=== Running containers in detached mode ==="
docker run -d -p 8082:8082 --name customers-service customers-service
docker run -d -p 8083:8083 --name vets-service vets-service
docker run -d -p 8084:8084 --name visits-service visits-service
docker run -d -p 8080:8080 --name api-gateway api-gateway

Write-Host "`nContainers started. Use 'docker ps' to check and 'docker logs -f <container_name>' to view logs."
