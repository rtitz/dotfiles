#!/bin/zsh
set -euo pipefail

sudo tmutil setdestination -p /Volumes/TimeMachine
sudo tmutil destinationinfo
sudo tmutil addexclusion -v /Volumes/external-0
sudo tmutil addexclusion -v /Volumes/TimeMachine
sudo tmutil addexclusion -v /Volumes/ramdisk_1g

# Exclusions Melanie
sudo tmutil addexclusion -p /Users/melanie/Downloads/
sudo tmutil addexclusion -p /Users/melanie/Music/
sudo tmutil addexclusion -p /Users/melanie/Movies/
sudo tmutil addexclusion -p /Users/melanie/tmp/
sudo tmutil addexclusion -p /Users/melanie/S3/
sudo tmutil addexclusion -p /Users/melanie/VirtualBox\ VMs/
sudo tmutil addexclusion -p /Users/melanie/Library/Containers/com.utmapp.UTM/
sudo tmutil addexclusion -p /Users/melanie/Library/Containers/com.docker.docker

# Exclusions Rene
sudo tmutil addexclusion -p /Users/rene/Downloads/
sudo tmutil addexclusion -p /Users/rene/Music/
sudo tmutil addexclusion -p /Users/rene/Movies/
sudo tmutil addexclusion -p /Users/rene/tmp/
sudo tmutil addexclusion -p /Users/rene/S3/
sudo tmutil addexclusion -p /Users/rene/VirtualBox\ VMs/
sudo tmutil addexclusion -p /Users/rene/Library/Containers/com.utmapp.UTM/
sudo tmutil addexclusion -p /Users/rene/Library/Containers/com.docker.docker

echo "Done."
