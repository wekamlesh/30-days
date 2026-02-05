#!/bin/bash

echo "===== SYSTEM INFO ====="
date
uptime
echo

echo "===== CPU & MEMORY ====="
free -h
echo

echo "===== DISK ====="
df -h
echo

echo "===== TOP CPU PROCESSES ====="
ps aux --sort=-%cpu | head -5
