# 📊 4주차 확장 - nginx 로그 분석 실습

nginx는 기본적으로 두 가지 로그 파일을 통해 웹 요청 및 오류를 기록합니다.  
운영/개발 환경 모두에서 문제 분석, 모니터링, 보안 점검 등에 매우 중요합니다.

---

## ✅ nginx 로그 파일 경로

| 로그 종류 | 파일 경로 |
|-----------|------------|
| access log | `/var/log/nginx/access.log` |
| error log  | `/var/log/nginx/error.log`  |

---

## 📘 access.log 예시

```
192.168.0.101 - - [07/Apr/2025:13:33:52 +0900] "GET /index.html HTTP/1.1" 200 153 "-" "curl/7.76.1"
```

| 필드 | 설명 |
|------|------|
| 192.168.0.101 | 클라이언트 IP |
| - -           | 인증 정보 (없음) |
| [07/Apr/2025...] | 요청 시간 |
| "GET /index.html HTTP/1.1" | 요청 메서드, 경로, HTTP 버전 |
| 200           | 응답 코드 (200, 404, 403 등) |
| 153           | 응답 바이트 수 |
| "-"           | Referrer (참조 페이지) |
| "curl/7.76.1" | User-Agent (브라우저 정보 등) |

---

## 📕 error.log 예시

```
2025/04/07 13:35:00 [error] 1234#0: *1 open() "/var/www/site1/notfound.html" failed (2: No such file or directory), client: 192.168.0.101, server: site1.local, request: "GET /notfound.html HTTP/1.1", host: "site1.local"
```

| 필드 | 설명 |
|------|------|
| [error] | 로그 레벨 (error, warn, notice 등) |
| open() failed | 에러 내용 |
| client | 요청한 IP 주소 |
| server | 해당 요청을 처리한 가상호스트 |
| request | 요청 라인 |
| host | 요청 도메인 |

---

## 🛠 실습 명령어

### 로그 보기

```bash
sudo tail -n 20 /var/log/nginx/access.log
sudo tail -n 20 /var/log/nginx/error.log
```

### 실시간 로그 확인

```bash
sudo tail -f /var/log/nginx/access.log
```

---

## 🧪 로그 테스트 예제

```bash
curl -A "DevOpsTest" http://site1.local/index.html
```

```bash
sudo tail -n 1 /var/log/nginx/access.log
```

→ "DevOpsTest" 라는 User-Agent가 남았는지 확인

---

## 🔍 로그 필터링 팁

```bash
# 404 에러만 보기
grep " 404 " /var/log/nginx/access.log

# 특정 IP 요청 보기
grep "192.168.0.101" /var/log/nginx/access.log

# 특정 URL 요청 확인
grep "/index.html" /var/log/nginx/access.log
```

---

## ✅ 마무리

- access.log는 요청 내역 추적용
- error.log는 문제 발생 시 확인
- 실시간 분석 + 필터링으로 운영에 활용 가능