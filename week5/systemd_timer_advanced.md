# ⏱️ systemd timer 고급 기능 정리

systemd의 `.timer` 유닛은 cron보다 정밀하고 유연한 스케줄링을 제공합니다.

---

## ✅ 1. OnCalendar= 를 활용한 정밀 스케줄

```ini
OnCalendar=*-*-* 01:30:00       # 매일 1시 30분
OnCalendar=Mon *-*-* 09:00:00   # 매주 월요일 09시 정각
OnCalendar=*-*-01 00:00:00      # 매월 1일 00시
```

- `*-*-*` : 매일
- `Mon` : 월요일
- `2025-04-14` : 특정 날짜

자세한 문법은 `man systemd.time` 참고

---

## ✅ 2. Persistent=true – 꺼져있던 동안 실행 못한 작업 자동 보완

```ini
[Timer]
OnCalendar=*-*-* 01:00:00
Persistent=true
```

- 시스템이 꺼져 있다가 지정된 시간이 지난 경우
- 다음 부팅 시 자동으로 한 번 실행

---

## ✅ 3. AccuracySec= – 실행 정확도 조절

```ini
AccuracySec=1s
```

- 실행 정확도를 1초 단위로 설정
- 기본값은 1분 (`1min`)
- 오차 범위 줄이고 싶을 때 사용

---

## ✅ 4. RandomizedDelaySec= – 랜덤한 지연 실행 (부하 분산용)

```ini
RandomizedDelaySec=10min
```

- 최대 10분 이내의 랜덤한 시간만큼 지연 후 실행
- 동시에 여러 타이머가 실행되는 것 방지

---

## ✅ 5. OnActiveSec, OnBootSec, OnStartupSec 차이

| 옵션                | 설명                                        |
| ------------------- | ------------------------------------------- |
| `OnActiveSec=5min`  | 서비스 활성화 후 5분 뒤 실행                |
| `OnBootSec=5min`    | 시스템 부팅 후 5분 뒤 실행                  |
| `OnStartupSec=5min` | systemd 초기화 후 5분 뒤 실행 (resume 포함) |

---

## ✅ 6. systemd-run 으로 타이머 없이 일회성 실행

```bash
systemd-run --on-active=10s echo "Hello after 10s"
```

- `.service` / `.timer` 파일 없이도 타이머 테스트 가능
- 일회성 작업에 유용

---

## 🧪 실습 아이디어

- `backup.sh` 같은 shell script 생성 후 `.timer`로 등록
- `/tmp/backup.log` 등에 로그 저장
- `Persistent`, `RandomizedDelaySec` 옵션 조합 실험

---

## 📌 요약 명령어

```bash
# 정밀 시간 스케줄
OnCalendar=Mon *-*-* 12:00:00

# 한 번만 실행 (일회성 타이머)
systemd-run --on-active=15s echo "Hello"

# 강제로 즉시 동기화
sudo chronyc makestep

# 타이머 상태 확인
systemctl list-timers
```

---
