#!/bin/bash
set -euo pipefail

echo "===== System Information ====="

echo "Current user:"
whoami

echo "Current date:"
date

echo "Disk usage:"
df -h
