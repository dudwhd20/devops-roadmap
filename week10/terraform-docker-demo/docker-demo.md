# Terraform + Docker Provider 실습 (terraform-docker-demo)

## 📦 환경 준비
- Terraform 설치 완료
- Docker Desktop 실행 상태 확인 (`docker info` 명령어로 점검)

---

## 📁 프로젝트 구조
```
terraform-docker-demo/
├── main.tf
└── provider.tf
```

---

## 📄 provider.tf
```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}
```

---

## 📄 main.tf
```hcl
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx-server"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 8080
  }
}
```

---

## ▶️ 실행 명령어
```bash
terraform init        # provider 설치
terraform plan        # 실행 계획 확인
terraform apply       # yes 입력
```

---

## 🧪 확인
```bash
docker ps             # nginx-server 컨테이너 확인
curl localhost:8080   # nginx 기본 페이지 출력
```

---

## 🧹 리소스 제거
```bash
terraform destroy
```

---

## ⚠️ 문제 해결 팁

| 문제 | 해결 방법 |
|------|------------|
| `docker_contianer` | 오타! → `docker_container`로 수정 |
| `.latest` 속성 없음 | `docker_image.nginx.name`으로 변경 |
| Docker 서버 오류 | Docker Desktop이 꺼져 있는 경우 → 재시작 필요 |