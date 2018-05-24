variable "domain" {
  description = "The domain url. \nEx. a.example.com"
}

variable "appName" {
  description = "The name of the application/service (No spaces)"
}

variable "repoName" {
  description = "The prefix of the repositories (must satisfy regular expression (?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*)"
}
