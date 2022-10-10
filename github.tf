provider "github" {}

data "github_user" "georgewitteman" {
  username = "georgewitteman"
}

data "github_repository" "terraform" {
  full_name = "georgewitteman/terraform"
}
