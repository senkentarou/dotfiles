# ref. https://github.com/tmknom/example-pragmatic-terraform/blob/main/02/2.1.1/1.tf
resource "aws_instance" "example" {
  ami           = "ami"
  instance_type = "t3.micro"
}
