# AWS 데이터 분석 서비스 정리

AWS는 다양한 데이터 분석 워크로드를 지원하기 위해 여러 서비스를 제공합니다. 이 문서는 주요 AWS 데이터 분석 서비스와 그 활용 사례를 요약한 것입니다.

---

## 1. Amazon Athena

- **개요**: S3에 저장된 데이터를 대상으로 SQL을 사용해 분석 가능한 인터랙티브 쿼리 서비스
- **특징**:
  - 서버리스 (인프라 관리 불필요)
  - S3 데이터를 그대로 분석
  - Presto 기반 SQL 지원
- **활용 사례**:
  - 로그 데이터 분석
  - 빠른 데이터 탐색 및 분석
  - S3 기반 데이터 레이크 분석

---

## 2. Amazon Redshift

- **개요**: 페타바이트 규모의 데이터 웨어하우스 서비스
- **특징**:
  - 컬럼 기반 저장 방식
  - 병렬 쿼리 처리 (MPP)
  - BI 도구와 연동 (QuickSight, Tableau 등)
- **활용 사례**:
  - 대규모 정형 데이터 분석
  - ETL 처리 후 집계/리포팅
  - 데이터 웨어하우스 구축

---

## 3. AWS Glue

- **개요**: 서버리스 데이터 통합 서비스로 ETL 작업을 자동화
- **특징**:
  - 크롤러 기능으로 메타데이터 자동 수집
  - PySpark 기반 ETL 코드 자동 생성
  - Glue Studio를 통한 시각화된 파이프라인 구성
- **활용 사례**:
  - 다양한 소스의 데이터 추출 → 변환 → 적재
  - S3 → Redshift, RDS 간 데이터 이동
  - 정형/반정형 데이터 전처리

---

## 4. Amazon EMR (Elastic MapReduce)

- **개요**: 대용량 데이터 처리용 Hadoop, Spark 기반 클러스터 서비스
- **특징**:
  - EC2 기반 클러스터 구성 (자동화 지원)
  - Spark, Hive, HBase, Presto 등 오픈소스 지원
  - 비용 최적화 가능 (스팟 인스턴스 활용)
- **활용 사례**:
  - 머신러닝 워크로드
  - 대규모 로그 처리 및 정제
  - 배치 기반의 빅데이터 처리

---

## 5. Amazon Kinesis

- **개요**: 실시간 데이터 스트리밍 및 분석 서비스
- **하위 서비스**:
  - **Kinesis Data Streams**: 실시간 데이터 수집
  - **Kinesis Data Firehose**: 실시간 데이터 적재 (S3, Redshift 등)
  - **Kinesis Data Analytics**: SQL 기반 실시간 스트리밍 분석
- **활용 사례**:
  - 실시간 IoT 센서 데이터 처리
  - 웹 클릭 스트림 분석
  - 실시간 모니터링 및 알림

---

## 6. AWS Lake Formation

- **개요**: 데이터 레이크를 쉽게 구축하고 관리할 수 있도록 도와주는 서비스
- **특징**:
  - 데이터 레이크 보안 및 권한 관리
  - 데이터 카탈로그 통합 관리
  - Glue와 연동하여 메타데이터 관리
- **활용 사례**:
  - 조직 전반의 데이터 거버넌스 강화
  - 중앙 집중형 데이터 레이크 구축

---

## 7. Amazon QuickSight

- **개요**: 클라우드 기반의 BI (Business Intelligence) 시각화 도구
- **특징**:
  - 서버리스 BI 대시보드 생성
  - ML 기반 인사이트 자동 제안
  - S3, Redshift, Athena, RDS 등과 연동
- **활용 사례**:
  - 대시보드로 KPI 시각화
  - 의사결정용 리포팅 도구
  - 실시간 데이터 분석 결과 공유

---

## 8. AWS Data Exchange

- **개요**: 서드파티 데이터를 AWS 환경 내에서 안전하게 구독 및 활용할 수 있는 서비스
- **특징**:
  - 신뢰할 수 있는 데이터 제공자들의 상업용 데이터 제공
  - 데이터 구독 및 갱신 자동화
- **활용 사례**:
  - 외부 경제/금융/위치 데이터 통합 분석
  - 보완적 시장 데이터 확보

---

## 비교 요약

| 서비스 | 주요 목적 | 데이터 처리 방식 | 실시간 지원 |
|--------|-----------|------------------|--------------|
| Athena | S3 데이터 쿼리 | SQL 쿼리 (서버리스) | ❌ |
| Redshift | 데이터 웨어하우스 | 컬럼 기반 MPP | ❌ |
| Glue | ETL 자동화 | PySpark 기반 | ❌ |
| EMR | 대용량 처리 | Spark, Hadoop | ❌ |
| Kinesis | 스트리밍 분석 | 실시간 스트림 | ✅ |
| Lake Formation | 데이터 레이크 관리 | 보안 + 권한 통합 | ❌ |
| QuickSight | 시각화 | BI 도구 | ❌(Refresh) |
| Data Exchange | 외부 데이터 연동 | 데이터 구독 | ❌ |

---

## 참고 링크

- [AWS Analytics 서비스 개요](https://aws.amazon.com/analytics/)
- [Amazon Redshift 공식 문서](https://docs.aws.amazon.com/redshift/)
- [AWS Glue 문서](https://docs.aws.amazon.com/glue/)
- [Amazon Kinesis 개요](https://aws.amazon.com/kinesis/)
- [QuickSight 소개](https://quicksight.aws.amazon.com/)

---

