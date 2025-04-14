# ⏱️ systemd Timer 유닛 – cron을 대체할 차세대 스케줄러

## 🎯 학습 목표

| 구분 | 내용 |
|------|------|
| 기본 이해 | `.timer` 유닛 구조와 작동 방식 |
| 실습 목표 | 주기적으로 실행되는 `.service` + `.timer` 구성 |
| 확장 개념 | `OnCalendar`, `AccuracySec`, `Persistent` 등 고급 속성 |

---

## ✅ 1단계: systemd timer란?

`systemd timer`는 전통적인 `cron`의 대체로 사용할 수 있는 **시스템 내장 스케줄러**다.

### ✨ 장점

- `.service`와 연결되어 유닛으로 관리됨
- `systemctl` 명령어로 제어 가능
- `journalctl`로 로그 통합
- `cron`보다 더 **정교한 시간 제어** 가능 (`OnBootSec`, `OnUnitActiveSec`, `OnCalendar` 등)

---

## ✅ 2단계: 기본 구조

### 📄 예제 구조

| 파일명 | 역할 |
|--------|------|
| `myjob.service` | 실행할 작업 정의 |
| `myjob.timer`   | 실행 시점 정의 |

---

## ✅ 3단계: 예제 만들기 (vi 편집기 사용 기준)

### 🔧 1. 서비스 유닛 작성

```bash
sudo vi /etc/systemd/system/myjob.service
```

```ini
[Unit]
Description=My Scheduled Job

[Service]
Type=oneshot
ExecStart=/usr/bin/echo "🕒 Timer triggered at $(date)" >> /home/devops/timer.log
```

> `Type=oneshot`: 한 번 실행하고 끝나는 서비스에 적합  
> `ExecStart`: 로그를 파일로 남기기 위한 예제

---

### 🔧 2. 타이머 유닛 작성

```bash
sudo vi /etc/systemd/system/myjob.timer
```

```ini
[Unit]
Description=Run myjob.service every minute

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
Unit=myjob.service

[Install]
WantedBy=timers.target
```

> `OnBootSec`: 부팅 후 1분 뒤 첫 실행  
> `OnUnitActiveSec`: 실행 후 1분마다 반복  
> `Unit`: 연결된 `.service` 지정

---

## ✅ 4단계: 타이머 활성화 및 실행 확인

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now myjob.timer
```

### 🔍 상태 확인

```bash
# 타이머 상태
systemctl list-timers
systemctl status myjob.timer

# 로그 확인
journalctl -u myjob.service
```

### 🔎 로그 파일 확인

```bash
cat /home/devops/timer.log
```

---

## ✅ 5단계: 고급 속성

| 옵션 | 설명 |
|------|------|
| `OnCalendar=Mon *-*-* 12:00:00` | 매주 월요일 12시에 실행 |
| `AccuracySec=1s`                | 실행 정확도 설정 |
| `Persistent=true`               | 시스템 꺼져 있어도 다음 부팅 시 누락된 작업 수행 |

---

## 🧪 실습 요약

```bash
# 유닛 등록
sudo vi /etc/systemd/system/myjob.service
sudo vi /etc/systemd/system/myjob.timer

# 반영 및 실행
sudo systemctl daemon-reload
sudo systemctl enable --now myjob.timer

# 실행 로그 보기
journalctl -u myjob.service
```

---

## 📌 참고

- 타이머는 `.service`가 반드시 필요하며 단독으로 동작하지 않음
- 시간 표현 방식은 `man systemd.time`으로 자세히 확인 가능
- 여러 주기를 조합할 수도 있음 (`OnCalendar`, `OnBootSec` 동시 사용 등)
