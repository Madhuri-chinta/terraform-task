resource "aws_instance" "instance" {
  ami                         = "ami-02eb7a4783e7e9317"
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  key_name                    = "key1"
  vpc_security_group_ids      = [aws_security_group.securitygroup.id]
  subnet_id                   = aws_subnet.subnet.id
  tags = {
    Name = "myinstance"
  }
}
