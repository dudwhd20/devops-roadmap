# 🌐 AWS Global Accelerator 정리

## 1. 개요

**AWS Global Accelerator**는 **AWS 그룹볼 네트워크 인프러**를 활용해서 전 세계 사용자에게 **더 빠른 및 안정적인 네트워크 라우팅**을 제공하는 서비스입니다.

> 간단하게 말하면, **인터넷 대신 AWS 백넘링맵**을 사용해 **지역 시청 감소**, **장애 시 자동 자육 조치**, **다중 리전 접근성**을 향상시킵니다.

---

## 2. 주요 기능

| 기능                        | 설명                                   |
| ------------------------- | ------------------------------------ |
| **Anycast IP 제공**         | 전 세계적으로 고정된 2개의 IPv4 주소 제공           |
| **트래픽 최적화**               | AWS 그룹볼 네트워크를 통해 가장 빠른 경로의 전송        |
| **장애 감지 및 자동 자육 조치**      | 헬스 체크를 통해 비정상 엔드포인트 감지 및 다른 리전 바로 돌림 |
| **ELB, EC2, ALB, NLB 지원** | 리전 내 다양한 리소스를 엔드포인트로 등록 가능           |
| **지역 시청 기반 라우팅**          | 사용자와 가장 가까워있는 리전으로 바로 라우팅            |

---

## 3. 구성 요소

### ✅ Accelerator

* Global Accelerator 인스턴스 단위
* 고정된 Anycast IP 주소 2개 제공

### ✅ Listener

* 포트와 프로토콜(TCP/UDP)을 정의
* 여러 개의 Listener를 하나의 Accelerator에 연결 가능

### ✅ Endpoint Group

* 특정 AWS 리전을 나타내내
* 각 리전마다 하나의 Endpoint Group
* 트래픽 분산 비율 및 헬스 체크 설정 가능

### ✅ Endpoint

* 실제 트래픽이 전달되는 대상 (ALB, NLB, EC2 등)
* 하나의 Endpoint Group 안에 여러 Endpoint 가능

---

## 4. 작동 흉륨

1. 사용자가 **Anycast IP**로 요청
2. Global Accelerator는 사용자의 위치를 기반으로 **가장 가까워있는 여름밀 로케이션**에서 AWS 그룹볼 네트워크로 트래픽 유입
3. 지정된 리전의 **Endpoint Group**로 트래픽 전달
4. **헬스 체크 실패 시**, 다른 리전의 정상적인 Endpoint로 **자동 자육 조치**

---

## 5. 사용 사례

* 전 세계 사용자 대상 그리고 시간에 문건이 무가하는 서비스 (API, 게임, 메이니)
* 경로 지역 BGP 장애 및 다른 리전으로 가는 지역 관성이 큰 사용자 객선
* 리전 답안 또는 장애에 대비한 자육 조치 수준이 복잡한 사용자

---

## 6. 비용

* Accelerator 시간당 요금
* 처리된 데이터 수량에 따라 요금 발생 (GB 단위)
* 가까워진 CloudFront 및 Route53 보다 비용이 더 높을 수 있음

[공식 요금 안내](https://aws.amazon.com/global-accelerator/pricing/)

---

## 7. Global Accelerator vs CloudFront

| 항목      | Global Accelerator | CloudFront                   |
| ------- | ------------------ | ---------------------------- |
| 주 목적    | TCP/UDP 애플리케이션 가속  | 정적/동적 컨테츠 캐시드                |
| 네트워크    | AWS 백넘링            | CDN (여름 캐시)                  |
| 사용 IP   | 고정 IP (Anycast)    | 도메인 (예: d123.cloudfront.net) |
| HTTP 지원 | 지정 안 됨             | HTTP/HTTPS 전용                |
| 대상      | ALB/NLB/EC2        | S3/ALB/EC2 등                 |

---

## 8. CLI/콘솔 사용

### 콘솔

1. Global Accelerator 서비스 선택
2. Accelerator 생성 → Listener 설정 → Endpoint Group/객체 설정

### CLI 예시

```bash
aws globalaccelerator create-accelerator --name my-accelerator --enabled
```

---

## 9. 참고 자료

* [AWS 공식 문서](https://docs.aws.amazon.com/global-accelerator/latest/dg/what-is-global-accelerator.html)
* [아키테카 예제 블로그](https://aws.amazon.com/blogs/networking-and-content-delivery/)

