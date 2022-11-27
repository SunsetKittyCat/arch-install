################################################################################
# Original Code Copyright (c) 2017 Mozilla (https://www.mozilla.org)
# Modified Code Copyright (c) 2022 SunsetKittyCat
#		(https://github.com/SunsetKittyCat)
#
# Licensed Under The Creative Commons Attribution Share-Alike 3.0 Unported
#		License (https://creativecommons.org/licenses/by-sa/3.0/deed.en)
#
# Original Code Was Posted To Mozilla's OpenSSH Article
#		(https://infosec.mozilla.org/guidelines/openssh) And Was Licensed Under
#		The Creative Commons Attribution Share-Alike 3.0 Unported License With
#		Attribution Required
#
# CHANGES
#
#  - Adapted The "OpenSSH client Configuration Modern" Section So That Its
#		Recommended ~/.ssh/config File Values Are Automatically Inserted Into
#		That File While Including The Code's License Via A Single echo Command

# Configure SSH Client
echo -e '# Original Code Copyright (c) 2017 Mozilla (https://www.mozilla.org)\n#\n# Licensed Under The Creative Commons Attribution Share-Alike 3.0 Unported\n#\t\tLicense (https://creativecommons.org/licenses/by-sa/3.0/deed.en)\n#\n# Original Code Was Posted To Mozilla'"'"'s OpenSSH Article\n#\t\t(https://infosec.mozilla.org/guidelines/openssh) And Was\n#\t\tLicensed Under The Creative Commons Attribution Share-Alike 3.0\n#\t\tUnported License With Attribution Required\n\n\n# Ensure KnownHosts are unreadable if leaked - it is otherwise easier to know which hosts your keys have access to.\nHashKnownHosts yes\n# Host keys the client accepts - order here is honored by OpenSSH\nHostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa,ecdsa-sha2-nistp521-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256\n\nKexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256\nMACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com\nCiphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr' > ~/.ssh/config

# Generate SSH Keys
ssh-keygen -t ed25519 -C "$(whoami)@$(uname -n)-$(date -I)"

################################################################################