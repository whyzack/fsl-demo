variable "name" {
  default = "fsl-devel"
}

variable "user_data" {
  default = <<EOF
#!/bin/bash
apt update;
apt install -y unzip docker*;
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip";
unzip awscliv2.zip;
./aws/install;
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 044723872363.dkr.ecr.us-east-1.amazonaws.com;
docker pull 044723872363.dkr.ecr.us-east-1.amazonaws.com/fsl-devel:latest;
docker run -d --name fsl-devel -p 80:3000 044723872363.dkr.ecr.us-east-1.amazonaws.com/fsl-devel:latest;
EOF
}