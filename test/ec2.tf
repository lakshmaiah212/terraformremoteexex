resource "aws_instance" "sonar" {
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0b4e3b9d8afb00cb4"]
  subnet_id = "subnet-0292e63a287192212"
  key_name = "endpoint"
   provisioner "remote-exec" {
    
       connection {
            type     = "ssh"
            user     = "${var.SSHUSR}"
            host     = "${self.public_ip}"
            port = 22
            password= "${var.SSHPASS}"
        
          
            
          }

    
    inline = [
      "sudo yum install ansible git -y",
    ]
  }

  tags = {
    Name = "studentapp"
    project_env = "TEST"
  }
}
