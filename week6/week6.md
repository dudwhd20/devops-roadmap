# 📦 6주차: 로그 및 모니터링 실습 정리

이 문서는 DevOps 6주차 실습으로, 시스템 로그 구조 이해부터 rsyslog 설정, logrotate 순환 설정, 리소스 모니터링, 경고 알림 스크립트까지 포함합니다.

## 📄 실습 구성 개요

## 1. 시스템 로그 구조 이해

Linux 시스템은 다양한 로그 파일을 `/var/log` 디렉토리에 저장합니다. 주요 로그는 다음과 같습니다:

| 파일명              | 설명                          |
| ------------------- | ----------------------------- |
| `/var/log/messages` | 시스템 전반의 일반 로그       |
| `/var/log/secure`   | 인증 관련 로그 (ssh, sudo 등) |
| `/var/log/dmesg`    | 부팅 시 커널 메시지           |
| `/var/log/boot.log` | 부팅 시 서비스 시작 로그      |
| `/var/log/cron`     | cron 잡 실행 결과             |
| `/var/log/httpd/`   | Apache 웹서버 로그            |
| `/var/log/nginx/`   | Nginx 웹서버 로그             |

접근 권한이 제한되며, `root`만 접근 가능한 로그도 존재합니다.

```bash
tail -f /var/log/secure
head -n 20 /var/log/messages
```

## 2. rsyslog 설정 실습

- 메인 설정: `/etc/rsyslog.conf`
- 서비스별 설정: `/etc/rsyslog.d/*.conf`

로그 저장 예시:

```conf
authpriv.*                /var/log/secure
```

사용자 정의 로그 설정 예:

```conf
if $programname == 'myapp' then /var/log/myapp.log
& stop
```

설정 반영:

```bash
sudo systemctl restart rsyslog
```

## 3. logrotate 설정 실습

- 기본 설정: `/etc/logrotate.conf`
- 서비스별 설정: `/etc/logrotate.d/*`

Nginx 예시:

```conf
/var/log/nginx/*.log {
    daily
    rotate 7
    compress
    create 0640 nginx adm
    postrotate
        [ -f /var/run/nginx.pid ] && kill -USR1 `cat /var/run/nginx.pid`
    endscript
}
```

강제 실행 테스트:

```bash
sudo logrotate -f /etc/logrotate.d/nginx
```

### 📌 메모리 경고 (`alert_memory.sh`)

```bash
#!/bin/bash
THRESHOLD=80
LOGFILE="/var/log/memory_alert.log"
USED_PERCENT=$(free | awk '/Mem:/ { printf("%.0f", ($3/$2)*100 ) }')

if [ "$USED_PERCENT" -ge "$THRESHOLD" ]; then
  NOW=$(date '+%Y-%m-%d %H:%M:%S')
  MESSAGE="[$NOW] 메모리 사용률 경고: ${USED_PERCENT}%"
  echo "$MESSAGE" >> "$LOGFILE"
  echo "$MESSAGE"
fi
```

### 📌 디스크 경고 (`alert_disk.sh`)

```bash
#!/bin/bash
MOUNT_POINTS=("/" "/home")
THRESHOLD=80
LOGFILE="/var/log/disk_alert.log"

for MP in "${MOUNT_POINTS[@]}"; do
  USAGE=$(df -h "$MP" | awk 'NR==2 {gsub("%", "", $5); print $5}')
  if [ "$USAGE" -ge "$THRESHOLD" ]; then
    NOW=$(date '+%Y-%m-%d %H:%M:%S')
    MESSAGE="[$NOW] 디스크 사용률 경고: $MP 사용률 ${USAGE}%"
    echo "$MESSAGE" >> "$LOGFILE"
    echo "$MESSAGE"
  fi
done
```

---

위 스크립트는 각각 메모리 사용률과 디스크 사용률이 설정된 임계치를 초과했을 때 경고 메시지를 로그로 저장하고, 필요 시 이메일이나 슬랙 연동도 가능하도록 확장할 수 있습니다.

또한 crontab 또는 systemd timer로 주기적인 실행을 등록하면 서버 리소스를 자동 모니터링할 수 있습니다.
