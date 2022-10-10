resource "aws_key_pair" "georgewitteman" {
  key_name   = "georgewitteman-personal"
  public_key = data.github_user.georgewitteman.ssh_keys[0]
}
