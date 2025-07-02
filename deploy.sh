#!/bin/bash
APP_DIR="/home/azureuser/app"

# SSH into GCP VM and deploy the app
ssh -o StrictHostKeyChecking=no azureuser@<GCP_VM_IP> <<EOF
  sudo apt update
  sudo apt install -y python3-pip
  mkdir -p $APP_DIR
  echo 'Uploading app...'
  exit
EOF

# Use SCP to upload files
scp app.py requirements.txt azureuser@<GCP_VM_IP>:$APP_DIR

# SSH again to install and run
ssh azureuser@<GCP_VM_IP> <<EOF
  cd $APP_DIR
  pip3 install -r requirements.txt
  nohup python3 app.py &
EOF
