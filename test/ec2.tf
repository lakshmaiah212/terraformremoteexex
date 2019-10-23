

resource "aws_key_pair" "ec2key" {
  key_name = "publickey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeONqUHQ9tOu0tw0NdBbeUzW86U435PK+1imK6Gsgw4kJ3Vz/YyQ9oXb+pDliRc1NpYBUv1lMvKSzC+EP8eN8qL2r4Ycpadb60isJHC43BHVzHMU3Nvv3+G6DocNM7nZTUhP6B7Shqt4x0hpQJsCRR9I1C5uu5LNMoETEuyUeiOsW1IPO/WD97um5rVcQZwCKKWGCylYO4SRiNqaNnhIYu+19lyCXBiq56N0eiABwkdrlaZkpFCNPB485Zsj8RUkMTiKN2jCytMS/i0R72EliizWUAi+6CSJ0yJA6Hj3wU7K3rU6sEVxPk6H82alxenS085Q9LTElPK5wTye8/NyeF ec2-user@ip-10-0-1-146.ec2.internal"
}

resource "aws_instance" "sonar" {
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0b4e3b9d8afb00cb4"]
  subnet_id = "subnet-0292e63a287192212"
  key_name = "${aws_key_pair.ec2key.key_name}"
   provisioner "remote-exec" {

       
       provisioner "file" {
          source      = "/home/ec2-user/.ssh/id_rsa"
          destination = "/home/ec2-user/.ssh/id_rsa"
       }
    
       connection {
            type     = "ssh"
            user     = "${var.SSHUSR}"
            host     = "${self.public_ip}"
            port = 22
            password= "${var.SSHPASS}"
            private_key = "${file2("home/ec2-user/.ssh/id_rsa")}"
          
            
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
