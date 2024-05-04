variable "image_id" {
  type = string
  description = "ID of the AWS AMI to use for the EC2 instance"
}

variable "username" {
  type = string
  # Usernames: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-to-linux-instance.html
  description = "The name of the user to log-in with"
}

variable "git_repo" {
  type = string
  description = "The URL to the Git repository to clone"
}

variable "instance_type" {
  type = string
  description = "The instance type to use on AWS"
  default = "t2.micro"
}
