# AWS Infrastructure with Terraform

This repository contains a Terraform script to deploy an AWS infrastructure with an ECS cluster, an Application Load Balancer (ALB), auto-scaling, and networking components.

## **Architecture Overview**

- **VPC** with Public and Private Subnets
- **ALB (Application Load Balancer)** listening on **port 80**, forwarding traffic to ECS tasks on **port 5000**
- **ECS Cluster** running Dockerized applications
- **ECS Tasks deployed in Private Subnets with NAT Gateway Access**
- **NAT Gateway** to provide internet access for all the instances under the private subnet
- **Application Load Balancer deployed in Public Subnets**
- **Auto Scaling** for ECS tasks
- **IAM Roles & Security Groups** for permissions
- **CloudWatch** for monitoring and logging

## **High Availability and Resilience**

- Setting the **az_count** variable allows the deployment to span multiple availability zones, increasing fault tolerance.
- Setting the **app_count** variable increases the number of ECS tasks/containers running within the ECS service, improving scalability and resilience.

## **CloudWatch Integration**

This deployment integrates AWS CloudWatch for monitoring and logging. The following CloudWatch components are used:

- **Log Groups**: Organizes application logs for better traceability.
- **Log Streams**: Captures ECS container logs in real-time for debugging.
- **Metrics & Alarms**: Tracks ECS task performance and triggers alerts based on threshold violations.
- **Event Rules**: Can be configured to take automated actions on specific events, such as ECS task failures.

## **Prerequisites**

Ensure you have the following installed before executing the Terraform script:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (>= 1.x)
- [AWS CLI](https://aws.amazon.com/cli/) (configured with credentials)
- AWS account with permissions to create resources (VPC, ECS, ALB, IAM, etc.)

## **Script Output Variables**

After successful execution, the script will print the following output variables with their values:

- **alb_hostname**: The hostname of the ALB. This can be used to verify the application.
- **ecs_cluster**: The name of the ECS cluster.
- **ecs_service**: The name of the ECS service.
- **task_def_arn**: The ARN of the ECS task definition.
- **app_container_name**: The name of the application container.

### **Usage of Output Variables in GitHub Repository-Level Environment Variables**

These output values should be mapped to environment variables in the main application's GitHub repository as follows:

- **alb_hostname** → Set as `APP_URL`
- **ecs_cluster** → Set as `ECS_CLUSTER`
- **ecs_service** → Set as `ECS_SERVICE`
- **task_def_arn** → Set as `TASK_DEF_ARN`
- **app_container_name** → Set as `APP_CONTAINER_NAME`

## **Required Variables**

Before running the script, you must provide values for the following variables:

- **aws_region**: AWS region where resources will be deployed.
- **app_port**: Port on which the application runs inside the container.
- **app_count**: Number of application instances (ECS tasks) to run.
- **app_image**: Docker image URL for the application.
- **vpc_cidr**: CIDR block for the VPC.

For demonstration purposes, these values have already been added in the `terraform.tfvars` file.

## **Setup and Deployment**

### **1. Clone the Repository**

```sh
git clone https://github.com/ambrishvadnerkar/AWS-ECS-Deployment-using-Terraform.git
cd AWS-ECS-Deployment-using-Terraform
```

### **2. Initialize Terraform**

```sh
terraform init
```

### **3. Review & Modify Variables**

Edit `terraform.tfvars` if needed to update values.

### **4. Validate the Terraform Configuration**

Run the following command to check if your Terraform configuration is valid:

```sh
terraform validate
```

### **5. Plan Deployment**

```sh
terraform plan
```

This will display the execution plan without making any changes.

### **6. Deploy Infrastructure**

```sh
terraform apply --auto-approve
```

This command will create all AWS resources.

### **7. Get Load Balancer URL**

```sh
echo "http://$(terraform output alb_hostname)"
```

Use this URL to access your application.

## **Destroying the Infrastructure**

To remove all resources, run:

```sh
terraform destroy --auto-approve
```

## **Potential Optimizations**

This Terraform deployment script can be further optimized by:

- **Modularizing the code** to improve reusability across different projects.
- **Parameterizing additional variables** for greater flexibility.
- **An S3 bucket** to store the terraform.tfstate file. Using a remote backend (using S3 bucket) allows Terraform to control the .tfstate remotely and store secrets and credentials.
- **A DynamoDB table** to create a locking mechanism
- **Enhancing logging and monitoring** to provide more actionable insights.



