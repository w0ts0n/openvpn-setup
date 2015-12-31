sudo su
# Update 
apt-get update -y
apt-get upgrade -y
# Install OpenVPN and iptables 
apt-get install openvpn udev iptables
# Copy easy-rsa directory
cp -R /usr/share/doc/openvpn/examples/easy-rsa/ /etc/openvpn
# Get into this directory
cd /etc/openvpn/easy-rsa/2.0/
# Make the variables
. /etc/openvpn/easy-rsa/2.0/vars
. /etc/openvpn/easy-rsa/2.0/clean-all
# Create the Certificate Authority
. /etc/openvpn/easy-rsa/2.0/build-ca
# Create a certificate/key for your server
. /etc/openvpn/easy-rsa/2.0/build-key-server server
# Create a client
. /etc/openvpn/easy-rsa/2.0/build-key client1
# Build the Diffie Hellman parameters
. /etc/openvpn/easy-rsa/2.0/build-dh
# Get into the keys directory
cd /etc/openvpn/easy-rsa/2.0/keys
# Copy the required keys to the /etc/openvpn directory
cp ca.crt ca.key dh1024.pem server.crt server.key /etc/openvpn
# Get into the sample config directory
cd /usr/share/doc/openvpn/examples/sample-config-files
# Unzip the server configuration files
gunzip -d server.conf.gz
# Copy the sample server configuration to /etc/openvpn
cp server.conf /etc/openvpn/
# Copy the sample client configuration to your home directory
cp client.conf ~/
# Get into your home directory
cd ~/
# Start OpenVPN
/etc/init.d/openvpn start
