### 📁 디렉토리 구조 예시

.
├── .env
├── check_server.sh
├── notify_slack.sh
└── notify_sms.sh

### 🔐 .env (환경 변수 파일, git에 커밋 금지)

```dotenv
# .env
TARGET_URL="http://localhost"
THRESHOLD=200

# Slack
SLACK_WEBHOOK="https://hooks.slack.com/services/XXX/XXX/XXX"

# Solapi (SMS)
SOLAPI_API_KEY="your_key"
SOLAPI_API_SECRET="your_secret"
SMS_FROM="0700000000"
SMS_TO="01012345678"
```

### ✅ check_server.sh

```bash
#!/bin/bash

source .env
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL")

if [ "$STATUS_CODE" -ne "$THRESHOLD" ]; then
    echo "[ALERT] 서버 응답 비정상 ($STATUS_CODE), 알림 전송"
    ./notify_slack.sh "$STATUS_CODE"
    ./notify_sms.sh "$STATUS_CODE"
fi
```

### ✅ notify_slack.sh

```bash
#!/bin/bash

source .env
STATUS_CODE=$1

MESSAGE="⚠️ $TARGET_URL 상태 비정상 (응답 코드: $STATUS_CODE)"

curl -X POST -H 'Content-type: application/json' \
     --data "{\"text\":\"$MESSAGE\"}" \
     "$SLACK_WEBHOOK"
```

### ✅ notify_sms.sh

```bash
#!/bin/bash

source .env
STATUS_CODE=$1

MESSAGE="[ALERT] 서버 상태 비정상! ($TARGET_URL : $STATUS_CODE)"

curl -X POST https://api.solapi.com/messages/v4/send \
     -H "Content-Type: application/json" \
     -u "$SOLAPI_API_KEY:$SOLAPI_API_SECRET" \
     -d "{
       \"message\": {
         \"to\": \"$SMS_TO\",
         \"from\": \"$SMS_FROM\",
         \"text\": \"$MESSAGE\"
       }
     }"
```

### 🛡 보안 Tip

- `.env`는 `.gitignore`에 반드시 추가 (`echo .env >> .gitignore`)
- cron에 등록할 때도 `cd ~/yourdir && ./check_server.sh` 식으로 상대경로 고려

### 🕒 crontab 등록 예시

```cron
*/5 * * * * cd /home/devops/test && ./check_server.sh >> check_server.log 2>&1
```

---
