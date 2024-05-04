# Création d'une clé privée et définition dans AWS
resource "tls_private_key" "my_private_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "key-pair"
  public_key = tls_private_key.my_private_key.public_key_openssh
}

# Ouverture des ports de la VM
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

# Déploiement de la VM et configuration de base
resource "aws_instance" "my_instance" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  connection {
    type        = "ssh"
    user        = var.username
    private_key = tls_private_key.my_private_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "file" {
    source = "install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "/tmp/install.sh ${var.git_repo}",
    ]
  }

  tags = {
    Name = "my-instance"
  }
}

# Affichage de l'adresse du site web qui a été déployé
output "deployed_website" {
  value = "Site web déployé sur : http://${aws_instance.my_instance.public_ip}"
}
