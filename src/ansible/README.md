sudo dnf update -y
sudo dnf install python3 -y
python3 -V
sudo yum install python3-devel
sudo yum groupinstall 'development tools'

sudo yum install ansible


## Comprobar conexión y generación de key
ssh-keygen -t rsa -b 4096