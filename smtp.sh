#!/bin/bash

# Step 1: Install postfix
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y postfix

# Step 2: Go to the /etc/postfix folder
cd /etc/postfix

# Step 3: Backup main.cf and clear duplicate smtp_tls_security_level entries
sudo cp main.cf main.cf.backup

# Remove existing smtp_tls_security_level entries if they exist
sudo sed -i '/^smtp_tls_security_level=/d' main.cf

# Step 4: Configure main.cf
sudo bash -c 'echo "relayhost = [smtp.gmail.com]:587" >> main.cf'
sudo bash -c 'echo "myhostname = $(hostname -f)" >> main.cf'
sudo bash -c 'echo "" >> main.cf'
sudo bash -c 'echo "# Location of sasl_passwd we saved" >> main.cf'
sudo bash -c 'echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd" >> main.cf'
sudo bash -c 'echo "" >> main.cf'
sudo bash -c 'echo "# Enables SASL authentication for postfix" >> main.cf'
sudo bash -c 'echo "smtp_sasl_auth_enable = yes" >> main.cf'
sudo bash -c 'echo "smtp_tls_security_level = encrypt" >> main.cf'
sudo bash -c 'echo "" >> main.cf'
sudo bash -c 'echo "# Disallow methods that allow anonymous authentication" >> main.cf'
sudo bash -c 'echo "smtp_sasl_security_options = noanonymous" >> main.cf'

# Step 5: Create sasl_passwd file and add Gmail credentials
sudo mkdir -p /etc/postfix/sasl
echo "[smtp.gmail.com]:587 pawan.sharma143600@gmail.com:hicg oeei yeaw snyy" | sudo tee /etc/postfix/sasl/sasl_passwd > /dev/null

# Step 6: Postmap sasl_passwd and restart postfix service
sudo postmap /etc/postfix/sasl/sasl_passwd
sudo systemctl restart postfix

# Step 7: Install mailutils to enable the 'mail' command
sudo apt install -y mailutils

# Step 8: Send a test email
echo "shyam fuddu hai" | mail -s "Postfix TEST" modim3912@gmail.com

echo "Setup completed. Check your email for the test message."