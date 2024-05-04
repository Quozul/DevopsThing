# Projet Devops
> L'objectif est de déployer un site web conteneurisé avec Docker sur une instance EC2 sur AWS.

## Variables

Le projet utilise 4 variables à définir dans le fichier `terraform/terraform.tfvars` :
- `image_id` : L'image AMI pour l'instance EC2
- `username` : Le nom d'utilisateur par défaut de l'image
- `git_repo` : Le dépôt contenant un fichier `docker-compose.yml` à la racine qui doit être clôné par Terraform sur l'instance
- `instance_type` : Le type d'instance à utiliser

## Utilisation

```sh
# Installation des dépendances (exemple pour ArchLinux)
sudo pacman -S terraform git

# Clôner le dépôt
git clone https://github.com/Quozul/DevopsThing.git project
cd project

# Déployer l'instance EC2
cd terraform
terraform plan
terraform apply
```
