resource "aws_key_pair" "fslKey" {
  key_name   = var.name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQColurGzgAO0cnovYecl/KwNTgD7NzgccSePX8norEwUVM5EhIHsIUkLKwwWIFcS9Di3/+k1WcHeuu0bez7QQnB8X/HFJ/LkS7p/3SNB+S4drdIL5qeAIxOPXkL0fDU3VkXS4aPLb0m4hCLGmrlzSaCDxcmhDhALN2+UBk/LbFwUK0OWJFpq1noOisgJmPKSioE5k3bwwBKoC3HnPPRzRbIafHK2B3UbqkDaN+JZ7djcCBDmVXT+x+nWQadksbwCkhjP8VaLbQwMk2wwslWvC6odd7td4WyNSEpbnrCwLhp6HdU9NjPOuPKx596VB9X1G3EWCuoJJfh3zX85fodAv9GlJJvf10QI2M75rPKO7sb4v+u3WMPgWJ9PbZzTsK/1yy3njNSrtjZ/DjECOimgnSHd4CRyereZi5v+xqNhknhlN56Wj5Db5lR8nAMxaPK1FvI//Oc8Fpja5FgQfce+0ePRh6UgxuDYDqjSYbRJHqxdc8Ap3E9HigOJgxFufVe7191IR0Rlcjhe56xeqdUSuX34KgC7kUwJWubaqJrdtWg3s/rB7++wu2caMXI9I1INBNY7gnBhWppUF3kFq/1+6f5pz9O0hF/nQ5muCTNmgzaj+fuSBLnqru9Pr7OEKn+5H8hEBjdm3s/76jl9xXKUn7Tscr/VaXkIGMVe4ry/iKboQ== uaizack@gmail.com"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.name
  vpc_security_group_ids = ["sg-04e71802572ef7697"]
  user_data              = var.user_data
  iam_instance_profile = var.name

  tags = {
    Name = var.name
  }
}