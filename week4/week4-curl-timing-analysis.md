# 🧪 curl 고급 사용법 - 응답 시간 분석 with `-w`, `-o`, `-s`

`curl` 명령어는 `-w` 옵션을 통해 요청의 소요 시간 등을 분석할 수 있습니다.  
아래는 그중 고급 실습 예시입니다:

---

## ✅ 전체 명령어

```bash
curl -w "@curl-format.txt" -o /dev/null -s http://site1.local
```

---

## 🧩 옵션 설명

| 옵션 | 설명 |
|------|------|
| `-w "@curl-format.txt"` | 응답 결과를 포맷팅하여 출력 |
| `-o /dev/null` | 응답 본문(HTML 등)은 출력하지 않음 |
| `-s` | silent 모드: 진행 상황, 에러 메시지 출력 안 함 |
| `http://site1.local` | 요청을 보낼 대상 URL |

---

## 📝 `curl-format.txt` 파일 예시

```text
time_namelookup:  %{time_namelookup}
time_connect:     %{time_connect}
time_starttransfer: %{time_starttransfer}
------------------------
total_time:       %{time_total}
```

---

## 📦 주요 write-out 변수 설명

| 변수 | 설명 |
|--------|------------------------------|
| `%{time_namelookup}` | DNS 조회에 걸린 시간 |
| `%{time_connect}` | TCP 연결까지 걸린 시간 |
| `%{time_starttransfer}` | 서버에서 첫 바이트가 전달되기까지 시간 |
| `%{time_total}` | 전체 요청-응답 완료까지 걸린 시간 |

---

## 📘 예시 출력

```bash
time_namelookup:  0.00123
time_connect:     0.00240
time_starttransfer: 0.00356
------------------------
total_time:       0.00402
```

---

## ✅ 활용 팁

- 사이트 응답 속도 측정
- API 응답 성능 분석
- 네트워크 지연 구간 파악 (DNS, 연결, 응답 등 분리)