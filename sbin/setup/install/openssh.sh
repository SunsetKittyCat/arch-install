# Install openssh For SSH Support
pacman --noconfirm --needed -S openssh


################################################################################
# Original Code Copyright (c) 2017 Proton Security
#		(https://www.positronsecurity.com/)
#
# Original Code Was Posted To Proton Security's SSH Hardening Guides Article
#		(https://www.ssh-audit.com/hardening_guides.html#ubuntu_20_04_lts)

rm /etc/ssh/ssh_host_*
ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""
ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

################################################################################


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
#  - Adapted The "OpenSSH server Configuration Modern (OpenSSH 6.7+)" Section
#		So That Its Recommended /etc/ssh/sshd_config File Values Are
#		Automatically Inserted Into That File While Including The Code's
#		License Via A Single echo Command

echo -e '# Original Code Copyright (c) 2017 Mozilla (https://www.mozilla.org)\n#\n# Licensed Under The Creative Commons Attribution Share-Alike 3.0 Unported\n#\t\tLicense (https://creativecommons.org/licenses/by-sa/3.0/deed.en)\n#\n# Original Code Was Posted To Mozilla'"'"'s OpenSSH Article\n#\t\t(https://infosec.mozilla.org/guidelines/openssh) And Was\n#\t\tLicensed Under The Creative Commons Attribution Share-Alike 3.0\n#\t\tUnported License With Attribution Required\n\n\n# Supported HostKey algorithms by order of preference.\nHostKey /etc/ssh/ssh_host_ed25519_key\nHostKey /etc/ssh/ssh_host_rsa_key\nHostKey /etc/ssh/ssh_host_ecdsa_key\n\nKexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256\n\nCiphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr\n\nMACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com\n\n# Password based logins are disabled - only public key based logins are allowed.\nAuthenticationMethods publickey\n\n# LogLevel VERBOSE logs user'"'"'s key fingerprint on login. Needed to have a clear audit track of which key was using to log in.\nLogLevel VERBOSE\n\n# Log sftp level file access (read/write/etc.) that would not be easily logged otherwise.\nSubsystem sftp  /usr/lib/ssh/sftp-server -f AUTHPRIV -l INFO\n\n# Root login is not allowed for auditing reasons. This is because it'"'"'s difficult to track which process belongs to which root user:\n#\n# On Linux, user sessions are tracking using a kernel-side session id, however, this session id is not recorded by OpenSSH.\n# Additionally, only tools such as systemd and auditd record the process session id.\n# On other OSes, the user session id is not necessarily recorded at all kernel-side.\n# Using regular users in combination with /bin/su or /usr/bin/sudo ensure a clear audit track.\nPermitRootLogin No' > /etc/ssh/sshd_config

awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.tmp
mv /etc/ssh/moduli.tmp /etc/ssh/moduli

################################################################################


systemctl enable sshd.service