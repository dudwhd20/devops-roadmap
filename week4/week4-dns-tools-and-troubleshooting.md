# 🌐 4주차 확장 - DNS 문제 해결 실습 정리

---

## ✅ 1. `/etc/resolv.conf`

### 📌 역할
- 리눅스에서 사용할 **DNS 서버 목록**을 정의하는 설정 파일
- 도메인 이름을 IP 주소로 변환할 때 참조

### 📂 예시

```text
nameserver 8.8.8.8
nameserver 1.1.1.1
```

> DNS가 안 되면 도메인으로 핑, curl 등 거의 모든 통신 실패

---

## ✅ 2. `/etc/hosts`

### 📌 역할
- 로컬에서 도메인 이름을 수동으로 지정
- DNS보다 우선 적용됨

### 📂 예시

```
127.0.0.1 site1.local
```

> 도메인 테스트용으로 자주 사용됨

---

## ✅ 3. ping

### 🛠 설명
- 도메인 해석이 되는지, 네트워크가 연결되는지 동시에 확인

```bash
ping google.com
```

- DNS 해석 + 연결 가능 여부 확인

---

## ✅ 4. dig

### 🔎 설명
- 도메인 이름에 대한 **DNS 정보 상세 분석**
- 구조화된 결과 제공

```bash
dig google.com
```

출력 항목:
- QUESTION SECTION
- ANSWER SECTION
- SERVER
- QUERY TIME 등

---

## ✅ 5. nslookup

### 🔍 설명
- 간단한 도메인 → IP, 또는 역방향(IP → 도메인) 질의

```bash
nslookup google.com
nslookup 8.8.8.8
```

- PTR 레코드가 등록된 경우만 역방향 결과 확인 가능

---

## ✅ 6. host

### 📦 설명
- 아주 간단하고 빠른 도메인/IP 해석 도구

```bash
host google.com
host 8.8.8.8
```

---

## ✅ 7. 역방향 DNS(PTR 레코드)

### 📘 개념
- **PTR (Pointer) 레코드**: 특정 IP에 연결된 도메인 이름을 알려주는 레코드
- 정방향은 A 레코드, 역방향은 PTR 레코드 사용

### 🔁 정방향 vs 역방향 비교

| 방향 | 설명 | 예시 |
|------|------|------|
| 정방향 | 도메인 → IP | `google.com` → `142.250.207.110` |
| 역방향 | IP → 도메인 | `142.250.207.110` → `kix06s11-in-f14.1e100.net` |

> 하나의 IP는 여러 도메인을 가질 수 있지만 PTR은 하나만 가능함

---

### 🔎 PTR 예시

```bash
nslookup 142.250.207.110
```

결과:

```
110.207.250.142.in-addr.arpa name = kix06s11-in-f14.1e100.net
```

- 구글 내부의 기술적 호스트명으로 표시
- `google.com`이라는 정확한 도메인은 알 수 없음

---

## ✅ 8. 도구 설치

### RHEL/Rocky 계열

```bash
sudo dnf install bind-utils
```

### Ubuntu 계열

```bash
sudo apt install dnsutils
```

---

## 📌 요약 비교표

| 명령어 | 기능 | 비고 |
|--------|------|------|
| `ping` | DNS + 연결 확인 | 빠른 체크 |
| `dig` | 상세 DNS 구조 확인 | 가장 정밀 |
| `nslookup` | IP ↔ 도메인 질의 | 쉽고 직관적 |
| `host` | 초간단 확인용 | 빠름 |
| `/etc/resolv.conf` | DNS 서버 설정 | 시스템 설정 |
| `/etc/hosts` | 로컬 도메인 오버라이드 | 테스트에 유용 |
| `PTR 레코드` | IP → 도메인 이름 저장 | 역방향 질의에 필요 |