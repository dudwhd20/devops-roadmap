# AWS CloudFront 정리

## 📌 CloudFront란?

Amazon CloudFront는 **콘텐츠 전송 네트워크(CDN)** 서비스로, 정적 및 동적 콘텐츠를 **전 세계 엣지 로케이션을 통해 빠르고 안전하게 전송**합니다. AWS S3, EC2, ALB는 물론 외부 오리진 서버도 지원합니다.

---

## ✅ 주요 특징

| 항목 | 설명 |
|------|------|
| 글로벌 캐시 | 엣지 로케이션에서 콘텐츠를 캐싱하여 지연 시간 최소화 |
| HTTPS 지원 | SSL/TLS로 암호화된 콘텐츠 전송 |
| 오리진 연동 | S3, EC2, ALB, 커스텀 오리진 등과 통합 |
| 동적 콘텐츠 | 쿠키, 쿼리 문자열, 헤더 기반 캐시 설정 |
| 캐시 제어 | TTL, 캐시 무효화(Invalidation) 기능 |
| 접근 제어 | 서명된 URL / 서명된 쿠키 기반 제한 |
| 비용 효율 | 데이터 전송량에 따른 비용 발생, 캐싱으로 비용 절감 가능 |

---

## 🧱 구성 요소

### 1. **오리진 (Origin)**
CloudFront가 콘텐츠를 가져오는 원본 서버  
- Amazon S3
- EC2 / ALB
- 외부 HTTP 서버

### 2. **배포 (Distribution)**
CloudFront에서 콘텐츠 전송을 위한 설정 단위  
- **Web Distribution** (정적/동적 웹 콘텐츠)
- (RTMP는 더 이상 사용되지 않음)

### 3. **엣지 로케이션 (Edge Location)**
전 세계에 분포된 캐시 서버로 사용자와 가장 가까운 위치에서 콘텐츠 제공

### 4. **캐시 동작(Cache Behavior)**
요청 경로에 따른 캐시 전략, 오리진 지정, TTL, 헤더/쿠키 처리 등 지정

---

## ⚙️ 설정 흐름

1. **S3 버킷 생성 또는 오리진 준비**
2. **CloudFront 배포 생성**
   - 오리진 도메인 설정
   - 캐시 동작 설정
   - Viewer Protocol Policy (HTTP/HTTPS 강제)
3. **도메인 연결 (Optional)**
   - 사용자 도메인(CNAME) 설정
   - ACM 인증서 연결
4. **정책 설정**
   - 접근 제한 정책 (Signed URL, Signed Cookie)
   - OAI (Origin Access Identity) 설정
5. **배포 완료 후 CloudFront URL 제공**
   - 예: `d1234abcde.cloudfront.net`

---

## 🔐 보안 설정

- **HTTPS 전송 필수화 (Redirect HTTP to HTTPS)**
- **OAI (Origin Access Identity)**: S3 콘텐츠 접근 제한
- **서명된 URL/쿠키**: 특정 사용자만 콘텐츠 접근 가능
- **WAF 연동**: 웹 공격 방지

---

## ⏱ 캐시 설정

| 설정 항목 | 설명 |
|-----------|------|
| TTL (Time to Live) | 콘텐츠가 엣지에 머무는 시간 |
| 캐시 무효화 | 특정 경로 콘텐츠 강제 업데이트 (`/*` 사용 주의) |
| 헤더/쿠키/쿼리문 | 요청 조건에 따라 캐시 분기 가능 |

---

## 🧪 실사용 예시 (정적 웹사이트)

```bash
# 정적 웹사이트를 CloudFront로 배포하는 예시 (S3 + OAI)

1. S3 버킷 생성 및 정적 웹 호스팅 활성화
2. CloudFront 배포 생성
   - 오리진: S3 버킷
   - Viewer Protocol Policy: Redirect HTTP to HTTPS
   - 캐시 동작: index.html, error.html 지정
3. OAI 생성 및 S3 버킷 정책에 추가
4. 사용자 도메인 연결 (Route53 또는 외부 DNS)
5. https://yourdomain.com 으로 접속 테스트
