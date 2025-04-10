# 🌐 DNS 레코드 총정리 마크다운

DNS는 도메인 이름과 관련된 다양한 정보를 저장하고 조회할 수 있는 시스템입니다.  
아래는 가장 많이 쓰이는 주요 레코드 타입들을 정리한 내용입니다.

---

## ✅ A 레코드 (Address)

- 도메인 이름 → IPv4 주소
- 가장 기본이 되는 DNS 레코드

```bash
dig google.com A
```

예시 결과:

```
google.com. 300 IN A 142.250.207.110
```

---

## ✅ AAAA 레코드

- 도메인 이름 → IPv6 주소
- A 레코드의 IPv6 버전

```bash
dig google.com AAAA
```

예시 결과:

```
google.com. 299 IN AAAA 2404:6800:4003:c0b::71
```

---

## ✅ CNAME 레코드 (Canonical Name)

- 도메인의 별명(별칭)을 다른 도메인에 연결
- 도메인 → 도메인

```bash
dig www.example.com CNAME
```

예시 결과:

```
www.example.com. 3600 IN CNAME example.com.
```

---

## ✅ NS 레코드 (Name Server)

- 도메인을 관리하는 네임서버를 지정
- DNS 질의 시 어떤 서버로 물어볼지 결정됨

```bash
dig google.com NS
```

예시 결과:

```
google.com. 21599 IN NS ns1.google.com.
```

---

## ✅ MX 레코드 (Mail Exchange)

- 메일 수신 서버를 지정
- 이메일을 받을 도메인의 우선순위 포함

```bash
dig google.com MX
```

예시 결과:

```
google.com. 3599 IN MX 10 smtp.google.com.
```

---

## ✅ TXT 레코드

- 도메인에 대한 설명, 인증 정보 등을 문자열로 저장
- SPF, DKIM, site verification 등에 활용

```bash
dig google.com TXT
```

예시 결과:

```
google.com. 3599 IN TXT "v=spf1 include:_spf.google.com ~all"
```

---

## ✅ PTR 레코드 (역방향)

- IP 주소 → 도메인 이름
- 역방향 DNS 질의 시 사용

```bash
dig -x 8.8.8.8
```

예시 결과:

```
8.8.8.8.in-addr.arpa. 86399 IN PTR dns.google.
```

---

## 📌 레코드 비교 요약

| 레코드 | 설명 | 질의 예시 |
|--------|------|------------|
| A      | 도메인 → IPv4 주소 | `dig example.com A` |
| AAAA   | 도메인 → IPv6 주소 | `dig example.com AAAA` |
| CNAME  | 도메인 → 도메인 (별명) | `dig www.example.com CNAME` |
| NS     | 도메인을 관리하는 네임서버 | `dig example.com NS` |
| MX     | 메일 서버 지정 | `dig example.com MX` |
| TXT    | 설명/인증 문자열 | `dig example.com TXT` |
| PTR    | IP → 도메인 이름 | `dig -x 8.8.8.8` |

---

## ✅ 마무리

- A/CNAME/NS/MX/TXT/PTR 등은 가장 많이 쓰이는 기본 레코드
- `dig`, `nslookup`, `host` 명령어로 확인 및 디버깅 가능