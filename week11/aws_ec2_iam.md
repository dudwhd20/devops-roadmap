# AWS IAM & EC2 시작 가이드

---

## ✅ IAM (Identity and Access Management) 기본 설정

### 1. IAM 사용자 생성하기

#### 📌 목적

루트 계정은 보안 위험이 높기 때문에, 별도의 IAM 사용자를 만들어 사용해야 합니다.

#### 🪜 단계별 가이드

1. AWS Management Console 접속 후, **IAM** 서비스로 이동
2. 좌측 메뉴에서 **사용자** 클릭 > **사용자 추가** 버튼 클릭
3. 사용자 이름 입력 (예: `admin-user`)
4. **액세스 유형**에서 다음 선택
   - 프로그래밍 방식 액세스 (CLI, SDK 사용 가능)
   - AWS Management Console 액세스 (웹 콘솔 사용 가능)
5. **비밀번호** 생성 (로그인용)
6. **권한 설정** 단계
   - "기존 정책 직접 연결" 선택
   - `AdministratorAccess` 정책 선택 (모든 리소스에 접근 가능)
7. 나머지는 기본값으로 두고 **사용자 생성** 클릭
8. 생성 완료 후 **Access Key ID**와 **Secret Access Key**는 꼭 저장해두기

> 🔥 주의: Secret Access Key는 다시 조회할 수 없습니다. 꼭 백업해두세요.

---

### 2. IAM 사용자로 로그인하기

- [AWS 로그인 페이지](https://aws.amazon.com/ko/console/) 이동
- 계정 ID 입력
- IAM 사용자 이름과 비밀번호 입력 후 로그인

---

## ✅ EC2 (Elastic Compute Cloud) 인스턴스 생성하기

### 1. EC2 인스턴스 생성

#### 📌 목적

AWS에서 가상 서버(리눅스 또는 윈도우)를 실행할 수 있도록 인스턴스를 생성합니다.

#### 🪜 단계별 가이드

1. AWS Management Console 접속 후, **EC2** 서비스로 이동
2. 상단의 **인스턴스 시작(Launch Instance)** 버튼 클릭

#### 인스턴스 설정

- **이름**: 원하는 이름 입력 (예: `test-server`)
- **애플리케이션 및 OS 이미지(AMI)**: `Amazon Linux 2023` 또는 `Ubuntu 22.04 LTS` 선택
- **인스턴스 유형**: `t2.micro` (프리티어 무료)
- **키 페어(로그인용)**:
  - 새 키 페어 생성
  - 이름 입력 후 키 페어를 **.pem 파일로 다운로드**
- **네트워크 설정**:
  - 퍼블릭 IP 자동 할당 활성화
  - 보안 그룹 생성: SSH(22) 포트 열기 (0.0.0.0/0으로 설정 시 주의)

#### 최종 확인 후 인스턴스 시작

- 인스턴스 시작 버튼 클릭

---

### 2. EC2 인스턴스 접속 (SSH)

#### 📌 목적

다운로드 받은 키 파일(.pem)을 이용해 EC2 서버에 접속합니다.

#### 🪜 접속 방법

1. 터미널(iTerm, Git Bash 등) 열기
2. 키 파일 권한 변경

```bash
chmod 400 your-key-name.pem
```

3. SSH 접속

```bash
ssh -i your-key-name.pem ec2-user@퍼블릭IP주소
```

- `ec2-user` : Amazon Linux 기본 계정
- `ubuntu` : Ubuntu AMI 사용 시 기본 계정

#### 예시

```bash
ssh -i mykey.pem ec2-user@3.123.456.789
```

> 🔥 접속이 안 될 경우:
>
> - 인바운드 규칙에 SSH(22) 포트 열렸는지 확인
> - 퍼블릭 IP가 바뀌었는지 확인
> - 키 파일(.pem) 경로와 권한 확인

---
