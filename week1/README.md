# 📁 Week 1 - Linux Basics 실습

## 🗂️ 실습 목적
- DevOps 엔지니어로서 서버를 다루기 위한 기본 Linux 명령어와 구조를 익힘
- 쉘 스크립트를 통해 반복 작업 자동화 개념 학습
- crontab으로 기본적인 스케줄링 자동화 경험

---

## 📌 실습 환경
- OS: macOS or Ubuntu 22.04 (VirtualBox or AWS EC2)
- Shell: bash
- 실습 위치: `~/devops-test`

---

## 🛠️ 사용 명령어 요약

| 카테고리 | 명령어 |
|----------|--------|
| 시스템 확인 | `uname`, `uptime`, `df -h`, `top`, `vm_stat` |
| 파일 조작 | `mkdir`, `touch`, `chmod`, `chown`, `ls` |
| 프로세스 | `ps aux`, `grep`, `curl localhost` |
| 네트워크 | `ifconfig`, `lsof -i`, `netstat` (Linux) |
| 자동화 | `crontab`, `bash`, `echo`, `date` |

---

## 📜 쉘 스크립트 예시: `check_server.sh`

```bash
#!/bin/bash
echo "===== 서버 상태 점검 ====="
date
echo "[디스크 사용량]"
df -h
echo "[메모리 상태]"
vm_stat | grep "Pages free"
echo "========================="
