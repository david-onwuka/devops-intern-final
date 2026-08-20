#!/bin/bash

set -euo pipefail

echo "===== System Information ====="
echo "Current user:"
whoami

echo
echo "Current date:"
date

echo
echo "Disk usage:"
df -h

echo "===== End of Report ====="
