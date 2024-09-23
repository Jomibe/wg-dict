#!/bin/bash

# Check if the user provided the desired prefix as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <prefix>"
    echo "Please provide a prefix to match the public key (e.g., abc)"
    exit 1
fi

# Assign the first argument to the prefix variable and convert it to lowercase
prefix=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# Initialize counters and time tracking
counter=0
start_time=$(date +%s)

# Function to generate a WireGuard key pair
generate_keys() {
    private_key=$(wg genkey)
    public_key=$(echo "$private_key" | wg pubkey)
    echo "$private_key" "$public_key"
}

# Loop until we find a public key that starts with the given prefix
while true; do
    key_pair=$(generate_keys)
    private_key=$(echo "$key_pair" | awk '{print $1}')
    public_key=$(echo "$key_pair" | awk '{print $2}')

    # Convert the public key to lowercase for case-insensitive comparison
    public_key_lower=$(echo "$public_key" | tr '[:upper:]' '[:lower:]')

    counter=$((counter + 1))
    
    # Calculate elapsed time
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))
    
    # Every 10 seconds, output the keys generated per second
    if (( elapsed_time >= 10 )); then
        keys_per_second=$(echo "scale=2; $counter / $elapsed_time" | bc)
        echo "Generated $counter keys in $elapsed_time seconds ($keys_per_second keys/second)"
        start_time=$current_time
        counter=0
    fi
    
    if [[ "$public_key_lower" == "$prefix"* ]]; then
        echo "Private Key: $private_key"
        echo "Public Key:  $public_key"
        break
    fi
done

