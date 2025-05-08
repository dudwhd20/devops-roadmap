# AWS 스토리지 서비스 비교 및 정리


---

## 1. Amazon FSx

### 개요

* Windows 및 Lustre 파일 시스템을 AWS에서 제공하는 완전관리형 파일 스토리지 서비스
* 기존 온프레미스 환경과 유사한 파일 시스템 필요 시 유용

### 지원 파일 시스템

* **FSx for Windows File Server**: SMB 기반, AD 통합 지원
* **FSx for Lustre**: 고성능 HPC 및 ML 워크로드용
* **FSx for NetApp ONTAP**: NetApp 데이터 관리 기능 포함 (NFS, SMB, iSCSI)
* **FSx for OpenZFS**: ZFS 기반 데이터 관리 가능

### 주요 사용 사례

* 파일 서버 마이그레이션
* HPC/AI/ML 고속 파일 I/O
* SAP, Windows 기반 애플리케이션 백엔드 저장소

---

## 2. AWS Snow Family

### 개요

* 대용량 데이터를 AWS로 이동하거나 엣지 컴퓨팅 환경에서 처리할 수 있는 하드웨어 장비 제공
* 네트워크가 느리거나 제한된 환경에서 데이터 마이그레이션 시 사용

### 제품군

* **Snowcone**: 소형 장비, 이동성 우수, 엣지 컴퓨팅
* **Snowball Edge**: 스토리지 최적화 및 컴퓨팅 최적화 모델 존재
* **Snowmobile**: 엑사바이트(EB) 단위 대규모 마이그레이션용 트럭 단위 장비

### 사용 사례

* 대규모 데이터센터 마이그레이션
* 엣지 컴퓨팅 (실시간 데이터 수집/분석)
* 데이터 수집 후 오프라인 전송

---

## 3. AWS Backup

### 개요

* 다양한 AWS 리소스에 대한 중앙 집중식 백업 서비스

### 특징

* 자동화된 백업 스케줄 설정
* 보존 정책 및 라이프사이클 관리
* 조직 전반 백업 정책 통합 관리 (Organizations 통합 가능)
* 복원 기능 포함

### 지원 서비스

* EBS, RDS, DynamoDB, EFS, FSx, EC2, Storage Gateway 등

### 사용 사례

* 규정 준수 및 장기 백업 저장소 운영
* 백업 표준화 및 감사 추적

---

## 4. AWS Transfer Family

### 개요

* 기존 FTP/SFTP/FTPS 기반 워크로드를 AWS 환경에서 관리 가능하도록 지원

### 특징

* Amazon S3 또는 Amazon EFS를 백엔드로 사용
* IAM 및 AD 기반 사용자 인증 지원
* 파일 전송 자동화 및 Lambda 연동 가능

### 사용 사례

* 파트너 또는 내부 시스템과의 정기적인 파일 전송
* SFTP 서버를 클라우드 기반으로 전환
* 보안 전송 자동화

---

## 5. AWS DataSync

### 개요

* 온프레미스 ↔ AWS 간 데이터 이동을 빠르고 안전하게 수행하는 서비스

### 특징

* 자동화된 증분 동기화
* EFS, FSx, S3, NFS, SMB 지원
* VPC 엔드포인트 및 암호화 지원
* 네트워크 효율 최적화 (압축, 병렬 처리)

### 사용 사례

* 대규모 데이터 마이그레이션
* 정기적인 온프레미스 → AWS 데이터 동기화
* 백업 또는 분석용 데이터 전송 자동화

---

## 서비스 비교 요약

| 서비스             | 주요 목적               | 대상 스토리지                      | 오프라인 지원 | 특징                       |
| --------------- | ------------------- | ---------------------------- | ------- | ------------------------ |
| FSx             | 고성능 파일 시스템          | Lustre, Windows, NetApp, ZFS | ✕       | 기존 시스템 대체 가능, SMB/NFS 지원 |
| Snow Family     | 대용량 마이그레이션, 엣지 처리   | 로컬 저장 장치                     | ✔       | 네트워크 불량 환경에서 유용          |
| AWS Backup      | 백업 자동화              | EBS, RDS 등 다양한 서비스           | ✕       | 규정 준수, 조직 전체 정책 적용       |
| Transfer Family | SFTP/FTP 전송 서버      | S3, EFS                      | ✕       | 기존 레거시 전송 자동화 대응         |
| DataSync        | 정기적 데이터 전송 및 마이그레이션 | S3, EFS, FSx                 | ✕       | 병렬/압축/암호화로 성능 최적화        |

---

## 참고 문서

* [https://docs.aws.amazon.com/fsx/](https://docs.aws.amazon.com/fsx/)
* [https://docs.aws.amazon.com/snowball/](https://docs.aws.amazon.com/snowball/)
* [https://docs.aws.amazon.com/aws-backup/](https://docs.aws.amazon.com/aws-backup/)
* [https://docs.aws.amazon.com/transfer/](https://docs.aws.amazon.com/transfer/)
* [https://docs.aws.amazon.com/datasync/](https://docs.aws.amazon.com/datasync/)

