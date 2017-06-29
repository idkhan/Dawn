# Check

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Install

apt install macchanger nmap aircrack-ng metasploit-framework
mkdir /etc/Dawn
cp dawn.sh /etc/Dawn/
echo "alias dawn=\"bash /etc/Dawn/dawn.sh\" " >> ~/.bashrc
echo "alias Dawn=\"bash /etc/Dawn/dawn.sh\" " >> ~/.bashrc

echo "Install Complete"
