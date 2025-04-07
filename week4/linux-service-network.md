## ✅ 1. `sudo`란?

- **Superuser DO**의 줄임말로, 현재 사용자가 **관리자(root)** 권한으로 명령어를 실행할 수 있게 해줌
- 주로 시스템 설정, 서비스 제어, 패키지 설치 등 **일반 사용자에겐 제한된 작업**에 사용됨

### 📌 예시

```bash
sudo dnf install nginx
sudo systemctl start nginx
sudo vi /etc/nginx/nginx.conf
```

### ⚠️ 주의

- 강력한 권한이므로 실수 시 시스템 전체에 영향을 줄 수 있음
- 실수로 `sudo rm -rf /` 같은 명령어를 실행하면 시스템이 망가짐

---

## 👤 2. `sudo` 가능한 사용자 만들기 (Rocky Linux 기준)

```bash
# 1. 유저 생성
sudo adduser devuser
sudo passwd devuser

# 2. wheel 그룹에 추가 (sudo 권한 부여)
sudo usermod -aG wheel devuser

# 3. sudo 권한 확인
su - devuser
sudo whoami    # 결과: root
```

> `wheel` 그룹은 sudo 권한이 부여된 관리자 그룹입니다.

---

## 🔧 3. 서비스 제어 - `systemctl`

```bash
sudo systemctl start nginx      # 서비스 시작
sudo systemctl stop nginx       # 서비스 중지
sudo systemctl restart nginx    # 서비스 재시작
sudo systemctl status nginx     # 상태 확인
sudo systemctl enable nginx     # 부팅 시 자동 시작 설정
sudo systemctl disable nginx    # 자동 시작 해제
```

---

## 🌐 4. 네트워크 관련 명령어

### 📍 IP 확인

```bash
ip a                # 모든 인터페이스 IP
ip addr show ens33  # 특정 인터페이스
```

### 🔌 포트 및 서비스 확인

```bash
ss -tuln            # 열려 있는 포트
sudo lsof -i :80    # 80 포트를 사용하는 프로세스
```

> `lsof` 설치 필요:

```bash
sudo dnf install -y lsof
```

### 🌍 외부 연결 확인

```bash
ping google.com         # 네트워크 연결 확인
curl http://example.com # 웹 응답 확인
```

> 일부 사이트는 보안을 위해 `ping` (ICMP)을 막아두었을 수 있음

### 🌐 DNS 확인

```bash
nslookup example.com  # 도메인 -> IP 조회
dig example.com       # 더 상세한 DNS 정보
```

> `nslookup`은 bind-utils 설치 필요:

```bash
sudo dnf install -y bind-utils
```

---

## 🧰 5. nginx 설치 및 설정

```bash
sudo dnf install -y epel-release
sudo dnf install -y nginx
sudo systemctl start nginx
```

### 📂 기본 경로

- 설정 파일: `/etc/nginx/nginx.conf`
- 웹 루트: `/usr/share/nginx/html`
- 기본 포트: 80

### ✅ 확인

```bash
curl http://localhost
ss -tuln | grep 80
```

---

## 🔥 6. 방화벽 설정

```bash
# 방화벽 상태 확인
sudo firewall-cmd --state

# 80 포트 열기
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --reload
```

---

## ✅ 설치 요약

```bash
# 필수 도구 설치
sudo dnf install -y bind-utils lsof curl epel-release
```

---

## 📌 기타 참고

- `sudo` 권한 부여된 그룹은 `/etc/sudoers` 또는 `visudo` 명령어로 설정 가능
- `wheel` 그룹 설정 줄:
  ```
  %wheel  ALL=(ALL)       ALL
  ```

---
