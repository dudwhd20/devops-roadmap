# Terraform + Docker Volume Mount 실습 (terraform-docker-volume-demo)

## ✅ 실습 목표
- Docker 컨테이너(NGINX)에 로컬 HTML 파일을 마운트
- 브라우저에서 정적 페이지 확인
- `mounts` 블록과 `abspath()` 함수 활용법 익히기

---

## 📁 디렉토리 구조
```
terraform-docker-volume-demo/
├── main.tf
├── provider.tf
└── html/
    └── index.html
```

---

## 📄 html/index.html
```html
<html>
  <body>
    <h1>Hello from Terraform Mounted Volume!</h1>
  </body>
</html>
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

resource "docker_container" "nginx_with_volume" {
  name  = "nginx-volume"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8081
  }

  mounts {
    target = "/usr/share/nginx/html"
    source = abspath("${path.module}/html")
    type   = "bind"
  }
}
```

---

## ▶️ 실행 명령어
```bash
terraform init
terraform apply
```

---

## 🌐 결과 확인
- 웹 브라우저에서: http://localhost:8081
- 또는:
```bash
curl localhost:8081
```

결과:
```
Hello from Terraform Mounted Volume!
```

---

## 🧹 리소스 정리
```bash
terraform destroy
```

---

## ⚠️ 주의사항 및 팁
| 문제 | 해결 방법 |
|------|------------|
| mount path must be absolute | `source = abspath(...)` 사용 |
| Docker 실행 오류 | Docker Desktop 실행 여부 확인 |

---

## 📌 사용한 Terraform 함수
- `abspath(path)`: 상대 경로를 절대 경로로 변환하는 내장 함수