#!/bin/bash

sudo apt-get update
sudo apt-get install wget -y


sudo mkdir -p /etc/gocron/
sudo touch /etc/gocron/gocron.yml
sudo chmod 600 /etc/gocron/config.yml


sudo tee /etc/gocron/config.yml << EOH
# This configuration file should be kept secret
# as it includes sensitive information such as passwords.
# Please 'chmod 700' this configuration file.
dbfqdn: "${dbfqdn}"
dbport: "${dbport}"
dbuser: "${dbuser}"
dbpass: "${dbpass}"
dbdatabase: "${dbdatabase}"
smtpserver: "${smtpserver}"
smtpport: "${smtpport}"
smtpaddress: "${smtpaddress}"
smtppassword: "${smtppassword}"
interval: ${interval}
slackhookurl: "${slackhookurl}"
slackchannel: "${slackchannel}"
preferslack: ${preferslack}
EOH

# Build systemd service
sudo touch /etc/systemd/system/gocron-back.service
sudo tee /etc/systemd/system/gocron-back.service << EOH
[Unit]
Description=GoCron Monitoring Service - Backend
After=network.target
[Service]
ExecStart=/usr/local/bin/gocron-back
[Install]
WantedBy=multi-user.target
EOH


sudo mkdir /usr/local/bin
cd /usr/local/bin
sudo wget "${release_url}"
sudo chmod +x /usr/local/bin/gocron-*


sudo systemctl enable gocron-back.service
sudo systemctl start gocron-back.service
sudo systemctl status gocron-back.service
