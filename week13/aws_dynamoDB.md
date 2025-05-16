# AWS DynamoDB 정리

## 개요

**Amazon DynamoDB**는 AWS에서 제공하는 완전관리형 NoSQL 데이터베이스 서비스입니다. 빠르고 예측 가능한 성능을 제공하며, 자동 확장이 가능합니다. JSON 형태의 Key-Value 또는 문서(Document) 데이터 모델을 사용합니다.

---

## 주요 특징

| 특징 | 설명 |
|------|------|
| 완전관리형(Managed) | 서버 관리 필요 없이 AWS에서 자동으로 관리 |
| 고가용성 | 여러 AZ(가용영역)에 걸쳐 자동으로 복제되어 내결함성 확보 |
| 무제한 확장성 | 수평적 확장 지원 (Auto Scaling) |
| 빠른 성능 | 마이크로초 단위의 응답 시간 |
| 서버리스 아키텍처 | EC2, RDS처럼 인프라를 직접 관리할 필요 없음 |

---

## 데이터 모델

### 테이블 구조

- **테이블**: 데이터가 저장되는 기본 단위
- **항목(Item)**: 테이블 내 하나의 레코드 (JSON 형태)
- **속성(Attribute)**: 항목의 데이터 필드

### 기본 키 구성

- **파티션 키 (Partition Key)**: 항목의 고유 식별자 역할, 해시 기반으로 저장 위치 결정
- **복합 키 (Partition Key + Sort Key)**: 파티션 키 외에도 정렬 키 추가로 동일 파티션 내 정렬 가능

---

## 사용 시나리오

- 실시간 분석 데이터 저장소
- IoT 센서 데이터 수집
- 사용자 세션 저장
- 게임 상태 관리
- 서버리스 백엔드 (Lambda + DynamoDB)

---

## 용량 설정

### 프로비저닝 모드 (Provisioned)

- 읽기/쓰기 처리량을 사전에 설정
- 비용은 설정한 처리량 기준

### 온디맨드 모드 (On-Demand)

- 요청량에 따라 자동으로 처리량 확장
- 예측 불가능한 트래픽에 유리

---

## 인덱스

- **기본 인덱스 (Primary Key)**: 테이블 생성 시 지정
- **GSI (Global Secondary Index)**: 파티션 키와 정렬 키를 새롭게 정의 가능
- **LSI (Local Secondary Index)**: 동일한 파티션 키에 다른 정렬 키 지정 가능 (테이블 생성 시만 정의 가능)

---

## 데이터 일관성

- **Eventually Consistent Reads (기본)**: 약간의 지연 후 최종적으로 일관된 데이터 보장
- **Strongly Consistent Reads**: 최신 데이터 보장 (읽기 성능 저하 가능성 있음)

---

## 보안

- IAM 정책으로 접근 제어
- VPC 엔드포인트를 통해 프라이빗 네트워크 접근 가능
- DynamoDB 암호화 기능 (at rest, in transit)

---

## 가격

- 읽기/쓰기 처리량, 저장된 데이터 용량, 전송량 등을 기준으로 과금
- 온디맨드와 프로비저닝에 따라 요금 방식 다름

자세한 가격은 공식 사이트 참조: [https://aws.amazon.com/dynamodb/pricing/](https://aws.amazon.com/dynamodb/pricing/)

---

## 연동 서비스

- **AWS Lambda**: 이벤트 기반으로 실시간 처리 가능
- **API Gateway**: RESTful API와 직접 연동
- **Kinesis Data Streams**: 변경 사항 실시간 스트리밍
- **CloudWatch**: 모니터링 및 알림

---

## 참고 명령어 (AWS CLI)

```bash
# 테이블 생성 예시
aws dynamodb create-table \
  --table-name Users \
  --attribute-definitions AttributeName=UserId,AttributeType=S \
  --key-schema AttributeName=UserId,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

# 테이블 조회
aws dynamodb scan --table-name Users
