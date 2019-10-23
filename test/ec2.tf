
resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = "${file("/home/ec2-user/.ssh/id_rsa.pub")}"
}
resource "aws_instance" "sonar" {
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0b4e3b9d8afb00cb4"]
  subnet_id = "subnet-0292e63a287192212"
  key_name = "${aws_key_pair.ec2key.key_name}"
   provisioner "remote-exec" {
    
       connection {
            type     = "ssh"
            user     = "${var.SSHUSR}"
            host     = "${self.public_ip}"
            port = 22
            password= "${var.SSHPASS}"
            private_key = "${file("home/ec2-user/.ssh/id_rsa")}"
            
            
          }

    
    inline = [
      "sudo yum install ansible git -y",
      "ansible-pull https://github.com/lakshmaiah212/ansible.git stack.yml",
    ]
  }

  tags = {
    Name = "studentapp"
    project_name = "${var.project_name}"
    project_env = "TEST"
  }
}
