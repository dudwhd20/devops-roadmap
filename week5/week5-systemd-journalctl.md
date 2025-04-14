# systemd 서비스 등록 실습 가이드 (DevOps용)

이 문서는 `systemd`를 사용해 사용자 정의 `.service` 유닛을 생성하고 등록하는 전체 과정을 실습할 수 있도록 정리한 가이드입니다. **실제 서비스 등록**, **오류 디버깅**, **로그 확인**까지 모두 포함되어 있습니다.

---

## 📌 1. systemd란?

`systemd`는 Linux에서 부팅, 서비스, 프로세스, 타이머 등을 관리하는 시스템 및 서비스 매니저입니다.

- 최신 배포판은 대부분 systemd 사용
- `.service`, `.target`, `.timer` 등 다양한 유닛 단위
- `journalctl`로 로그 통합 관리

---

## ⚙️ 2. 서비스 유닛(.service) 기본 구조

```ini
[Unit]
Description=서비스 설명
After=network.target

[Service]
ExecStart=실행할 명령어
Restart=always
User=사용자명
WorkingDirectory=작업 디렉터리

[Install]
WantedBy=multi-user.target
```

- `[Unit]`: 의존성 정의
- `[Service]`: 실제 실행 동작 및 사용자 정의
- `[Install]`: 서비스 활성화 대상(target) 설정

---

## 🛠 3. 실습: Python 앱 서비스 등록하기

### 3.1 Python 앱 생성

```bash
mkdir -p ~/myapp
vi ~/myapp/app.py
```

```python
#!/usr/bin/env python3
import time

while True:
    print("Running my app...")
    time.sleep(5)
```

```bash
chmod +x ~/myapp/app.py
```

### 3.2 systemd 서비스 파일 생성

```bash
sudo vi /etc/systemd/system/myapp.service
```

```ini
[Unit]
Description=My Test Python App
After=network.target

[Service]
ExecStart=/usr/bin/python3 /home/devops/myapp/app.py
Restart=always
User=devops
WorkingDirectory=/home/devops/myapp

[Install]
WantedBy=multi-user.target
```

**⚠️ 주의:** `User=devops` 는 실제 존재하는 사용자 계정이어야 함 (`whoami`로 확인)

### 3.3 등록 및 실행

```bash
sudo systemctl daemon-reload
sudo systemctl enable myapp
sudo systemctl start myapp
```

---

## 🧪 4. 로그 확인 및 디버깅

### 4.1 서비스 상태 확인

```bash
sudo systemctl status myapp
```

### 4.2 로그 확인

```bash
sudo journalctl -u myapp.service -f
```

### 4.3 자주 발생하는 오류

| 에러 메시지                                             | 원인 및 해결                                                          |
| ------------------------------------------------------- | --------------------------------------------------------------------- |
| `Failed to determine user credentials: No such process` | `User=` 항목에 존재하지 않는 사용자 지정 → 실제 계정으로 수정         |
| `status=217/USER`                                       | 위와 동일                                                             |
| `ExecStart=... No such file or directory`               | 실행 경로 오타, 존재하지 않음 → `which python3` 등으로 실제 경로 확인 |

---

## 🔄 5. 서비스 수정 시 주의사항

```bash
# 1. 파일 수정 후 반드시 reload
sudo systemctl daemon-reload

# 2. 재시작
sudo systemctl restart myapp
```

서비스 수정 후 reload를 하지 않으면 변경 내용이 반영되지 않음.

---

## 📌 참고 명령어 모음

| 명령어                    | 설명                   |
| ------------------------- | ---------------------- |
| `systemctl start name`    | 서비스 시작            |
| `systemctl stop name`     | 서비스 중지            |
| `systemctl restart name`  | 서비스 재시작          |
| `systemctl enable name`   | 부팅 시 자동 실행 등록 |
| `systemctl disable name`  | 자동 실행 해제         |
| `systemctl status name`   | 상태 확인              |
| `journalctl -u name`      | 로그 확인              |
| `systemctl daemon-reload` | 유닛 변경 사항 반영    |

---

## ✅ 마무리 체크리스트

- [x] Python 파일 실행 확인
- [x] `.service` 파일 작성 및 권한 설정
- [x] `User=` 필드에 올바른 사용자 지정
- [x] `daemon-reload` 후 실행 및 enable
- [x] `journalctl`로 로그 확인

---

## 📁 다음 학습 추천

- `Environment=`로 환경변수 설정하기
- `ExecStartPre=`, `ExecStop=` 추가로 전/후 작업 정의
- `RestartSec=`, `TimeoutSec=` 고급 설정
- `systemd timer`를 활용한 스케줄링 (crontab 대체)
