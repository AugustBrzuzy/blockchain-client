# blockchain-client

This project is a simple blockchain client that interacts with the Polygon network using JSON-RPC. 
It provides API endpoints to fetch the latest block number and retrieve block details by number.

The API gets deployed to ECS service in AWS through Terraform.

## Features
- Developed using **FastAPI**
- Fetch latest block number from Polygon RPC
- Fetch block details by block number
- Unit tests included using **pytest**
- Containerized with **Docker**
- Deployment configuration provided via **Terraform** for AWS ECS Fargate

## Running the Application

prerequisites:
- python
- docker

### Locally
1. Install dependencies:
   ```sh
   pip install -r requirements.txt
   ```
2. Run the application:
   ```sh
   uvicorn main:app --host 127.0.0.1 --port 8000
   ```
   to access on localhost

### Using Docker
1. Build the Docker image:
   ```sh
   docker build -t blockchain-client .
   ```
2. Run the container:
   ```sh
   docker run -p 8000:8000 blockchain-client
   ```

## API Endpoints
- **GET /block/number** - Fetches the latest block number.
- **GET /block/{block_number}** - Fetches block details for a given block number.

## Testing
Run tests with:
```sh
pytest pytest/test_main.py
```

## Infrastructure (Terraform)
- Uses **AWS ECS Fargate** for serverless container deployment.
- Creates an ECS execution role through AWS IAM that enables to pull an image from ECR
- assumes pre-existing resources like VPC, Subnet, SecurityGroup and ECR

## Github workflows
The project utilizes simple GH workflows to:
- validate infrastructure code (validate-infra.yml[.github/workflows/validate-infra.yml])
- deploy a tested and built app to ECR and create an ECS infrastructure stack that pulls image from ECR (deployment.yml[.github/workflows/deployment.yml])