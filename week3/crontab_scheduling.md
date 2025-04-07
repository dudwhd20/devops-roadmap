# Linux Crontab 자동 실행 스케줄링

DevOps 및 시스템 운영에서 자주 사용되는 작업 자동화 도구인 `crontab`의 사용법과 예제를 정리한 문서입니다.

---

## ✅ 기본 구조

```
* * * * * 명령어
│ │ │ │ │
│ │ │ │ └─ 요일 (0~7, 일요일=0 또는 7)
│ │ │ └──── 월 (1~12)
│ │ └─────── 일 (1~31)
│ └───────── 시 (0~23)
└──────────── 분 (0~59)
```

---

## ✅ crontab 명령어

| 명령어       | 설명                         |
|--------------|------------------------------|
| `crontab -e` | 현재 사용자 크론 편집        |
| `crontab -l` | 현재 사용자 크론 목록 보기   |
| `crontab -r` | 현재 사용자 크론 전체 삭제   |

> 편집기는 기본적으로 `vi` 또는 `nano` 사용

---

## ✅ 실습 예제

### 1. 매분마다 hello.sh 실행

```bash
* * * * * /home/user/hello.sh
```

### 2. 매일 새벽 3시 로그 백업

```bash
0 3 * * * /home/user/backup_logs.sh
```

### 3. 매주 월요일 자정 리포트 생성

```bash
0 0 * * 1 /home/user/report.sh
```

### 4. 특정 월(3월, 6월)에만 실행

```bash
0 9 * 3,6 * /home/user/special_task.sh
```

---

## ✅ 환경 변수 설정

```bash
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin
```

> cron 환경은 제한적이므로 필요한 변수는 명시해주는 것이 좋습니다.

---

## 🐛 디버깅 팁

- 로그로 출력 결과 확인하기

```bash
* * * * * /home/user/job.sh >> /home/user/job.log 2>&1
```

- cron 로그 확인:
  - RHEL/CentOS/Rocky Linux 계열: `/var/log/cron`
  - 또는 `journalctl -u crond` 명령어 사용

---

## ✅ 요약 정리

- `crontab -e`로 편집
- 절대경로로 스크립트 지정
- 실행 권한 (`chmod +x`) 확인
- `PATH`, `SHELL` 설정 추가 가능
- 로그 리다이렉션 (`>> logfile 2>&1`) 활용

---

> 📌 이 문서는 DevOps 3주차 교육의 마지막 파트인 Crontab 예약 실행 내용을 정리한 실습 문서입니다.
