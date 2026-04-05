provider "aws" {
  region = "ap-south-1"
}

module "ecr" {
  source = "../../modules/ecr"

  repo_name   = "my-backend"
  environment = "dev"
}

module "ec2" {
  source = "../../modules/ec2"

  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  name          = "infra-ai"
  user_data     = <<-EOF
                  #!/bin/bash
                  set -e
                  apt update -y
                  apt install -y docker.io curl unzip
                  systemctl start docker
                  systemctl enable docker
                  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                  unzip awscliv2.zip
                  ./aws/install
                  aws ecr get-login-password --region ap-south-1 \
                  | docker login --username AWS --password-stdin 678882708618.dkr.ecr.ap-south-1.amazonaws.com
                  docker pull 678882708618.dkr.ecr.ap-south-1.amazonaws.com/my-backend:latest
                  docker run -d -p 80:8000 \
                  678882708618.dkr.ecr.ap-south-1.amazonaws.com/my-backend:latest
                EOF
  iam_instance_profile = module.iam.instance_profile_name

}

module "iam" {
  source = "../../modules/iam"

  role_name = "ec2-ecr-role"
}