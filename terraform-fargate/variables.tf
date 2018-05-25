variable "domain" {
  description = "The domain url. \nEx. a.example.com"
}

variable "appName" {
  description = "The name of the application/service (No spaces)"
}

variable "repoName" {
  description = "The prefix of the repositories (must satisfy regular expression (?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*)"
}

variable "vpcId" {
  description = "The id of the system vpc"
}

variable "executionRoleArn" {
  description = "The arn of the execution role"
}

variable "appSubnetId" {
  description = "The first subnet to use"
}

variable "appSubnetId2" {
  description = "The second subnet to use"
}

variable "appPublicSecurityGroupId" {
  description = "The id of the security group"
}
