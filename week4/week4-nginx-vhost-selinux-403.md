# 🌐 4주차 확장 - nginx 가상 호스트 + SELinux + 403 에러 해결 정리

---

## ✅ 1. nginx 가상 호스트(Virtual Host) 설정

### 🧱 실습 목표

- nginx에서 도메인 별로 서로 다른 페이지를 서빙하도록 설정
- 예: `site1.local` → site1 페이지, `site2.local` → site2 페이지

---

### 📁 웹 루트 디렉토리 및 테스트 페이지 생성

```bash
sudo mkdir -p /var/www/site1
sudo mkdir -p /var/www/site2

echo "This is SITE 1" | sudo tee /var/www/site1/index.html
echo "This is SITE 2" | sudo tee /var/www/site2/index.html
```

---

### ⚙️ nginx 가상 호스트 설정 파일

#### `/etc/nginx/conf.d/site1.conf`

```nginx
server {
    listen 80;
    server_name site1.local;

    root /var/www/site1;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

#### `/etc/nginx/conf.d/site2.conf`

```nginx
server {
    listen 80;
    server_name site2.local;

    root /var/www/site2;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

---

### 🧪 테스트를 위한 hosts 파일 설정

#### macOS / Linux

```bash
sudo vi /etc/hosts
```

#### Windows

```
C:\Windows\System32\drivers\etc\hosts
```

#### 추가할 내용

```
127.0.0.1 site1.local
127.0.0.1 site2.local
```

※ 위 IP는 실제 VM의 IP로 바꿔주세요.

---

### ✅ nginx 설정 적용 및 테스트

```bash
sudo nginx -t
sudo systemctl reload nginx
```

```bash
curl http://site1.local   # → "This is SITE 1"
curl http://site2.local   # → "This is SITE 2"
```

---

## 403 에러 이슈가 생겨 아래와 검색 결과 Rocky 리눅스 관련 해결 방법을 찾음

## 🔐 2. SELinux 완전 기초와 403 에러 해결

### 📌 SELinux란?

**SELinux(Security-Enhanced Linux)**는 리눅스 시스템의 보안을 강화하기 위한 커널 수준의 보안 모듈입니다.  
NSA(미국 국가안보국)에서 만든 기능으로, 프로세스와 자원의 상호작용을 세밀하게 제어합니다.

---

### 📋 SELinux 모드

| 모드         | 설명                                |
| ------------ | ----------------------------------- |
| `Enforcing`  | 보안 정책을 강제 적용. 위반 시 차단 |
| `Permissive` | 위반은 허용하지만 로그만 기록       |
| `Disabled`   | SELinux 기능 완전히 꺼짐            |

```bash
getenforce     # 현재 동작 모드 출력
sestatus       # 전체 SELinux 정보 출력
```

---

### ⚠️ nginx에서 403 Forbidden 에러 발생 시 조치

#### 1. 퍼미션 확인

```bash
sudo chmod -R 755 /var/www/site1
sudo chown -R nginx:nginx /var/www/site1
```

#### 2. SELinux 일시 비활성화

```bash
sudo setenforce 0
getenforce
```

---

### ✅ SELinux 영구 비활성화 방법

```bash
sudo vi /etc/selinux/config
```

수정:

```ini
SELINUX=disabled
```

변경 후 재부팅:

```bash
sudo reboot
```

확인:

```bash
getenforce  # Disabled
```

---

## ✅ 마무리

- SELinux는 보안에 유용하지만 개발 중에는 제약이 많을 수 있음
- nginx 가상 호스트를 쓸 땐 파일 권한, SELinux, hosts 설정을 모두 확인할 것
- 모든 설정 변경 후엔 항상 `nginx -t && systemctl reload nginx` 필수
