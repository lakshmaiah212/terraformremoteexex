

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
    
       connection {
            type     = "ssh"
            user     = "${var.SSHUSR}"
            host     = "${self.public_ip}"
            port = 22
            password= "${var.SSHPASS}"
            private_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA3jjalB0PbTrtLcNDXQW3lM1vOlON+TyvtYpiuhrIMOJCd1c/
2MkPaF2/qQ5YkXNTaWAVL9ZTLykswvhD/HjfKi9q+GHKWnW+tIrCRwuNwR1cxzFN
zb79/hug6HDTO52U1IT+ge0oareMdIaUCbAkUfSNQubruSzTKBExLslHojrFtSDz
v1g/e7pua1XEGcAiilhgspWDuEkYjamjZ4SGLvtfZcglwYquejdHogAcJHa5WmZK
RQjTwePOWbI/EVJDE4ijdowsrTEv4tEe9hJYos1lAIvugkidMiQOh498FOyt61Or
BFcT5Oh/NmpcXp0tPOUPS0xJTyucE8nvPzcnhQIDAQABAoIBAQCHNgio/lWYnLYb
lieyvfvJqoX280f7UpWG3EDeA9WzCLhwbMIIYa3iTsiDUJtLROSHxVKe3MWYeHEn
4G9dex4uSNPJdZbuG56Bs7wqBjmmOvtsp+8zNPbOWnk5dQzRxTv9Yz6IR4jEBhKM
BCanDmnLBAW/o0niTgfc5TkLwqS3a/CZ+VG8cXxFEi/RD6AtErfNDfhT9s91wbrW
UMxtlRXw0E60aRNBByYMJz0sVGtUpOHI0P7qVU04YBf2nE4MKEhkH3fmJJPDf6Fl
xtebd8bmaVU6OTq1cWcH6Ol4M3uY4loPfnKOhCxdBh29eOcOzOl7zvDpZs9yey9z
g1YTLWOBAoGBAPvTWciRIJjYAvIGLShmyMMkc1zx5JbFq5jBa1xQYEN9JTgULlbW
lCjR9d6dUAq8s2HYgFfZB3CSqeCxmfQMTpYuAUwqPtq2bFU/4qQKuQcyg0gPGQsI
8T/LzJcwbaKBuEDyCJgENVRKRbPhrciMdkxucy4yenRN8moEr5eSToIdAoGBAOHn
4J54fODqcsL3sKabwlAewC5k5F2TKBADovMndtLSdfyOvtCS0K0hm+wdj6MHDWLf
YTyJnNQ3II4CJsw8hMn2m0SrhNpZDHf99tfDD8Grjnl4Oasdo4B4PZ+mc06Rpsij
XbRW3Cn2FzvI3le7h0B76Glm8FV/SxuFScnHir6JAoGBAOQSP7+JyQcEpG5EL8Pm
iy9JpP3pykjPECGSE8UQuo6FGh9XD7zwLFFoDxEmUqbWznPwnBRz5+wJuLdawn8o
YkhbtCsiG7kD/Mucx4wgdgFRu1qY6ep3l99amZnYb4L9jz2qtyPOs+n6NnS7ESSQ
KlgAtGqDpyoMql9gjRNum5H1AoGBALIhYmfzAB1mIRoFr4Cgn2cH6Ghs2/nBWLzP
8USkoLh6hdihQms66VsrfkR/xsw5el+1Xnoa1NQtp/jyT1+KdPbAAwzx5m85+m//
jQ3zXNBNE6pKl8aLN2rM5WKnIJManJXm47OZLj/UMdvNdy1czLiXO9so9WelWTcZ
Mebu9kNpAoGAbq2HeHcB6vNp6wLkhUlvmPowNo8qPUl68nnVfPLfp+ruUI7Askaq
43/3lvwEzDfM3oFDOiqmWvGv131OeQBpmNWdCz30gwoIQCYoxrTehfzs8FtTg+Sp
SiOd5QFSMtkqT6LD1AWonQwUueu5Kod5rVM7Zd+qA2809Dht7aZnp5Y=
-----END RSA PRIVATE KEY-----
"
          
            
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
