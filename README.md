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

## Github workflows
The project utilizes simple GH workflows to:
- validate infrastructure code - [validate-infra.yml](https://github.com/AugustBrzuzy/blockchain-client/blob/main/.github/workflows/validate-infra.yml)
- deploy a tested and built app to ECR and create an ECS infrastructure stack that pulls image from ECR - [deployment.yml](https://github.com/AugustBrzuzy/blockchain-client/blob/main/.github/workflows/deployment.yml)

## **Production Readiness Considerations**

To make this project production-ready, the following enhancements should be considered:

### **1. Security Improvements**
- **API Authentication**: Implement API keys or OAuth2 authentication to restrict access.
- **HTTPS Enforcement**: Use a load balancer with an SSL certificate to ensure secure communication.
- **Environment Variables**: Store sensitive data (e.g., API keys) in AWS Secrets Manager or Parameter Store.
- **IAM Role Refinement**: Ensure the ECS task execution role has the minimum required permissions to interact with ECR and other AWS services.
- **Terraform State Security**: Store the Terraform state file in an S3 bucket with encryption enabled and use state locking.

### **2. Performance Optimization**
- **Application scalability**: Implement asynchronous model to enable the application to serve request for many subsequent clients and/or implement replication with shared distributed storage.
- **Caching**: Use a caching layer (e.g., Redis or AWS ElastiCache) to reduce redundant calls to the Polygon RPC API.
- **Rate Limiting**: Implement rate limiting in FastAPI to prevent abuse and ensure fair usage of the API.
- **Load Balancing**: Deploy the ECS service behind an AWS Application Load Balancer (ALB) for better scalability and fault tolerance.
- **Auto-scaling**: Configure ECS Fargate auto-scaling policies to handle traffic spikes dynamically.
- **Optimize Docker Image**: Use a smaller base image (e.g., `python:3.10-alpine`) to reduce the Docker image size and improve deployment speed.

### **3. High Availability & Fault Tolerance**
- **Multi-AZ Deployment**: Deploy the ECS service across multiple availability zones to ensure high availability.
- **Health Checks**: Configure ECS health checks to automatically restart failing containers.
- **Disaster Recovery**: Implement automated backups for critical data and infrastructure configurations.

### **4. Observability & Debugging**
- **Centralized Logging**: Use AWS CloudWatch Logs to aggregate and monitor application logs from ECS tasks.
- **Tracing**: Integrate distributed tracing tools to trace API requests and identify bottlenecks.
- **Metrics and Alerts**: Use AWS CloudWatch Metrics and Alarms to monitor ECS service performance and set up alerts for critical issues.
- **Error Handling**: Improve error handling in the FastAPI application to return meaningful error messages and log detailed stack traces.

### **5. CI/CD Pipeline**
- **Automated Testing**: Expand the test suite to include integration and end-to-end tests. Ensure all tests are run in the CI pipeline.
- **Docker Image Scanning**: Use tools like AWS ECR image scanning or Trivy to detect vulnerabilities in the Docker image.
- **Terraform Validation**: Ensure the `validate-infra.yml` workflow validates and plans Terraform changes before deployment.
- **Artifact Management**: Store Terraform plans (`tfplan`) as artifacts in GitHub Actions for review before applying.
- **Rollbacks**: Implement rollback mechanisms in the CI/CD pipeline to revert to a previous stable state in case of deployment failures.

### **6. Cost Optimization**
- **Spot Instances**: Use spot pricing for ECS tasks to reduce costs while maintaining availability.
- **Idle Resource Cleanup**: Use AWS Lambda or AWS Config rules to identify and clean up unused resources (e.g., old ECR images, unused ECS tasks).
- **Monitoring Cost Usage**: Enable AWS Cost Explorer and set up budgets and alerts to track and control infrastructure costs.
- **Optimize Resource Allocation**: Review and adjust ECS task definitions (CPU and memory) to avoid over-provisioning.