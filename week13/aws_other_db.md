# AWS 기타 데이터베이스 서비스 간단 정리

이 문서는 RDS, Aurora, DynamoDB 외에 AWS에서 제공하는 다양한 데이터베이스 서비스를 간단히 정리한 것입니다.

---

## 1. Amazon Redshift

- **유형**: 데이터 웨어하우스 (OLAP)
- **특징**: 대규모 데이터 분석에 최적화, 컬럼 기반 저장
- **사용 예시**: BI 분석, 로그 분석, 대시보드 구축

---

## 2. Amazon Timestream

- **유형**: 시계열 데이터베이스
- **특징**: IoT 및 시계열 센서 데이터 저장/쿼리 최적화
- **사용 예시**: 장비 센서 데이터, 서버 모니터링 로그

---

## 3. Amazon Neptune

- **유형**: 그래프 데이터베이스
- **지원 쿼리**: Gremlin (Property Graph), SPARQL (RDF)
- **사용 예시**: 소셜 네트워크, 추천 시스템, 관계 분석

---

## 4. Amazon DocumentDB

- **유형**: 문서 기반 NoSQL
- **호환성**: MongoDB API 호환
- **사용 예시**: JSON 문서 저장, 콘텐츠 관리 시스템 (CMS)

---

## 5. Amazon QLDB (Quantum Ledger DB)

- **유형**: 변경 불가능한 원장형 데이터베이스
- **특징**: 블록체인 유사 구조 (변조 불가, 감사 추적)
- **사용 예시**: 금융 거래 기록, 로그 추적, 공급망 이력 관리

---

## 6. Amazon Keyspaces (for Apache Cassandra)

- **유형**: 분산형 Wide Column NoSQL
- **호환성**: Apache Cassandra 쿼리 언어(CQL)
- **사용 예시**: 대규모 분산 로그, 사용자 활동 기록

---

## 참고

각 서비스는 AWS 공식 홈페이지에서 더 자세한 요금 및 사용 사례를 확인할 수 있습니다.

- 공식 문서: https://aws.amazon.com/products/databases/
