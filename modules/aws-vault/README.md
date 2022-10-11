# Vault

Heavily influenced by https://github.com/hashicorp/terraform-aws-vault-starter.

```bash
. /etc/profile

# Initialize cluser (IMPORTANT: Be sure to save the keys/tokens)
vault operator init

# Check status of the vault cluster
export VAULT_TOKEN="<your Vault token>"
vault operator raft list-peers

# Verify raft settings
vault operator raft autopilot get-config

# Enable dead server cleanup (needs min-quorum to be at least 3)
vault operator raft autopilot set-config -cleanup-dead-servers=true -dead-server-last-contact-threshold=10 -min-quorum=3
```
