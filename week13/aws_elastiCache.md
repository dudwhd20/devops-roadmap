# AWS ElastiCache 정리

## 개요

**Amazon ElastiCache**는 클라우드에서 완전관리형 인메모리 데이터 저장소 및 캐시 서비스입니다. 고속 응답이 필요한 애플리케이션에서 사용되며, Redis 또는 Memcached 엔진을 선택할 수 있습니다.

---

## 주요 특징

| 항목 | 설명 |
|------|------|
| 관리형 서비스 | AWS가 자동으로 클러스터 관리, 패치, 모니터링을 처리 |
| 고속 응답 | 밀리초(ms) 단위 응답 시간 |
| 확장성 | 자동 샤딩, 리플리케이션, 클러스터링 기능 지원 |
| 가용성 | Multi-AZ 구성 가능, 장애 조치(automatic failover) 지원 |
| 보안 | VPC 지원, IAM 통합, TLS 암호화 및 AUTH 인증 지원 |

---

## 지원 엔진

### 1. Redis
- 단일 스레드 기반의 키-값 저장소
- 고급 데이터 구조 (List, Set, Sorted Set 등) 지원
- 복제, 자동 장애 조치, 클러스터링 지원
- TTL (Time-To-Live) 설정 가능

### 2. Memcached
- 멀티 스레드 기반, 매우 단순한 key-value 캐시
- 복제, 영속성, 클러스터링 없음
- 수평 확장에 유리함

---

## 사용 사례

- **세션 저장소**: 로그인 세션 등 사용자 세션 데이터 저장
- **캐싱 계층**: 자주 조회되는 DB 결과나 API 응답 캐싱
- **리더보드 및 카운터**: 게임 리더보드, 실시간 카운트
- **Pub/Sub**: Redis의 publish/subscribe 기능 활용

---

## 배포 옵션

- **Cluster Mode Disabled (비클러스터 모드)**: 단일 shard 구성, 복제본 구성 가능
- **Cluster Mode Enabled (클러스터 모드)**: 여러 shard로 구성하여 자동 파티셔닝 가능

---

## 보안

- **VPC 지원**: VPC 내에 배치하여 네트워크 보안 확보
- **IAM 권한**: 콘솔 및 API 액세스 제어
- **TLS 암호화**: 전송 중 데이터 암호화
- **Redis AUTH**: 패스워드 인증

---

## 모니터링

- **Amazon CloudWatch**: 성능 지표 확인 (CPU, Network, Memory 등)
- **Slow Log**: Redis의 느린 명령어 로그 확인

---

## 비용

- EC2 인스턴스 기반으로 과금 (온디맨드 또는 예약 인스턴스)
- 백업 스토리지, 데이터 전송량도 과금 대상

---

## 실습 예시 (Redis 클러스터 생성 CLI)

```bash
aws elasticache create-replication-group \
    --replication-group-id my-redis-cluster \
    --replication-group-description "My Redis Cluster" \
    --engine redis \
    --cache-node-type cache.t3.micro \
    --num-node-groups 1 \
    --replicas-per-node-group 1 \
    --automatic-failover-enabled \
    --cache-subnet-group-name my-subnet-group \
    --security-group-ids sg-xxxxxx
