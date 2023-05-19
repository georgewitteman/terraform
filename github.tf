provider "github" {}

data "github_repository" "terraform" {
  full_name = "georgewitteman/terraform"
}
