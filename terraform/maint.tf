variable "commit_id" {
  description = "Identifiant unique pour différencier chaque instance (ex: hash du commit)"
  type        = string
  default     = "default"
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true

  endpoints {
    ec2 = "http://ip10-0-6-4-d0dgqa805akh4glkf8qg-4566.direct.lab-boris.fr"
  }
}

resource "aws_instance" "demo" {
  ami           = "ami-${var.commit_id}"  # ID fictif mais différent à chaque commit
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-${var.commit_id}"
  }
}

output "created_instance_id" {
  value = aws_instance.demo.id
}
