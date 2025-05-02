# AWS EC2 심화 파트 2: Auto Scaling, ELB, AMI 등

---

## ✅ 1. Auto Scaling Group (ASG)

### 📌 개요

- EC2 인스턴스를 자동으로 늘리고 줄이는 기능
- 수요에 맞춰 서버 수를 조정하여 비용 최적화 및 고가용성 확보

### 구성 요소

| 구성 요소          | 설명                                              |
| :----------------- | :------------------------------------------------ |
| Launch Template    | 어떤 인스턴스를 어떻게 띄울지 정의 (AMI, 타입 등) |
| Auto Scaling Group | 인스턴스 묶음. 최소, 최대, 원하는 개수 설정       |
| Scaling Policy     | 증감 조건 (CPU 사용률, SQS 메시지 수 등)          |
| Lifecycle Hook     | 인스턴스 생성/종료 시 커스텀 작업 실행 가능       |

### 스케일링 방식

- **동적 스케일링 (Dynamic Scaling)**: 실시간 지표 기반 자동 조정
- **예측 스케일링 (Predictive Scaling)**: AI가 수요 예측 후 선제적 증감
- **수동 조정 (Manual Scaling)**: 직접 개수 설정

---

## ✅ 2. Elastic Load Balancer (ELB)

### 📌 개요

- 여러 인스턴스로 트래픽을 분산하여 고가용성 확보
- 헬스체크를 통해 죽은 인스턴스를 자동 제외

### 종류 및 차이점

| 종류                            | 계층       | 특징                                       |
| :------------------------------ | :--------- | :----------------------------------------- |
| ALB (Application Load Balancer) | L7         | HTTP/HTTPS 기반, URL/Host 기반 라우팅 가능 |
| NLB (Network Load Balancer)     | L4         | 고성능 TCP 트래픽 처리, 지연 짧음          |
| CLB (Classic Load Balancer)     | L4+L7 혼합 | 구버전, 점점 사용 줄어듦                   |

### 주요 기능

- 대상 그룹 (Target Group)으로 백엔드 서버 구성
- HTTPS 사용 시 SSL 종료(TLS Termination)
- 고정 세션 유지 (Sticky Session) 지원

---

## ✅ 3. AMI (Amazon Machine Image) 관리 전략

### 📌 AMI란?

- EC2 인스턴스의 OS, 설정, 애플리케이션, 데이터 등을 포함한 이미지
- 인스턴스를 빠르게 복제하거나 재생성할 수 있음

### 관리 전략

- 운영 환경에서는 **배포용 AMI**를 만들고 관리
- **버전 관리 태그** 필수 (ex: `web-v1.2.3`)
- 오래된 AMI는 **스냅샷만 보존**하고 삭제하여 비용 절감

### AMI 생성 방법

- 콘솔 또는 CLI에서 실행 중인 인스턴스에서 생성 가능

```bash
aws ec2 create-image --instance-id i-xxxxxx --name "MyAppImage-v1"
```

---

## ✅ 4. EC2 Image Builder

### 📌 개요

- 자동화된 AMI 생성 파이프라인
- 패치 적용, 커스텀 소프트웨어 설치, 보안 기준 적용 후 이미지 생성

### 주요 구성 요소

| 구성 요소    | 설명                                          |
| :----------- | :-------------------------------------------- |
| Source Image | 기반이 될 AMI (ex. Ubuntu 22.04)              |
| Component    | 설치 스크립트 또는 구성 작업 (ex. nginx 설치) |
| Pipeline     | 자동 생성 스케줄 및 트리거                    |
| Output Image | 최종적으로 생성된 AMI 결과물                  |

### 사용 시 장점

- 수동 생성 없이 주기적으로 보안 업데이트된 AMI 생성 가능
- 컴플라이언스 기준 적용에도 유리함

---

# ✨ 요약 정리

- Auto Scaling은 고가용성과 비용 최적화를 동시에 달성
- ELB는 L7/L4 기반으로 트래픽을 지능적으로 분산시킴
- AMI는 서버 복제 및 빠른 롤백에 필수, 자동화는 Image Builder로 해결

---

# 📌 다음 예정

- S3(Simple Storage Service) 기본 및 심화 이론
