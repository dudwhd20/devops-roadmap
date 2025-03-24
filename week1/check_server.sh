
### 💻 쉘 스크립트 샘플 2종

### 📦 샘플 1: 서버 상태 점검(`check_server.sh`)
#!/bin/bash

echo "=== [Server Health Check] ==="
echo "Date       : $(date)"
echo "Uptime     : $(uptime)"
echo "Disk Use   :"
df -h
echo "Memory     :"
vm_stat |grep "Page free"
echo "============================="
