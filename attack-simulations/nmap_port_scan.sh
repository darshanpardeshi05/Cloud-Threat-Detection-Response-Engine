#!/bin/bash
# Simulate port scanning on an EC2 instance
TARGET_IP="YOUR_EC2_PUBLIC_IP"
nmap -Pn -T4 -p 22,80,443,8080 $TARGET_IP