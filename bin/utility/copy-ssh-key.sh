# Prompt For Remote Machine URL
read -ep 'SSH Server URL: ' SSH_URL

# Authorise Logins On A Remote Machine
ssh-copy-id $SSH_URL