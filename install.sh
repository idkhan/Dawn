# Check

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Install

apt install nmap 
apt install metasploit-framework 
apt install aircrack-ng
apt install net-tools

echo Depencies Installed

ls /etc/ | grep "Dawn" || mkdir /etc/Dawn

cp dawn.sh /etc/Dawn/

grep "alias dawn=\"bash /etc/Dawn/dawn.sh" ~/.bashrc || echo "alias dawn=\"bash /etc/Dawn/dawn.sh\" " >> ~/.bashrc

grep "alias Dawn=\"bash /etc/Dawn/dawn.sh" ~/.bashrc || echo "alias Dawn=\"bash /etc/Dawn/dawn.sh\" " >> ~/.bashrc

echo
echo "Install Complete"
echo "To run write Dawn"
