resource "aws_key_pair" "georgewitteman" {
  count = length(data.github_user.georgewitteman.ssh_keys)

  key_name   = "georgewitteman-personal-${count.index}"
  public_key = element(data.github_user.georgewitteman.ssh_keys, count.index)
}
