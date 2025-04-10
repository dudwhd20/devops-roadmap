# 🌐 4주차 확장 - curl을 이용한 REST API 테스트 실습

`curl`은 커맨드라인에서 HTTP 요청을 보내고 응답을 확인할 수 있는 매우 강력한 도구입니다.  
REST API 테스트, 정적 페이지 요청 확인, 헤더/바디 조작 등에 사용됩니다.

---

## ✅ 기본 GET 요청

```bash
curl http://example.com
```

---

## 🧪 실습 1: nginx 정적 페이지 요청 확인

```bash
curl -i http://site1.local/index.html
```

옵션 설명:
- `-i`: 응답 헤더도 함께 출력

---

## 🧪 실습 2: REST API 테스트 (json-server 또는 테스트용 API)

### 1. GET 요청

```bash
curl -X GET http://localhost:3000/users
```

### 2. POST 요청 (JSON 데이터 전송)

```bash
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice", "email": "alice@example.com"}'
```

---

## 🧰 curl 주요 옵션 정리

| 옵션 | 설명 |
|------|------|
| `-X` | 요청 메서드 지정 (GET, POST, PUT, DELETE 등) |
| `-H` | HTTP 헤더 지정 |
| `-d` | 요청 본문 데이터 지정 |
| `-i` | 응답 헤더 포함 |
| `-s` | silent 모드 (진행바, 오류 숨김) |
| `-o` | 출력 파일 저장 |

---

## 🧪 실습 3: 사용자 정의 User-Agent

```bash
curl -A "DevOps-Test" http://site1.local
```

---

## 🧪 실습 4: 서버 응답 시간 확인

```bash
curl -w "@curl-format.txt" -o /dev/null -s http://site1.local
```

`curl-format.txt` 예시:

```
time_namelookup:  %{time_namelookup}
time_connect:     %{time_connect}
time_starttransfer: %{time_starttransfer}
------------------------
total_time:       %{time_total}
```

---

## ✅ 정리

- `curl`은 HTTP 요청 테스트 및 디버깅에 매우 유용
- REST API 요청 실습 시 `-X`, `-H`, `-d` 옵션 자주 사용
- nginx + curl 조합으로 로그 기반 분석도 가능