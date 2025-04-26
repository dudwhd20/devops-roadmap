# Terraform + Docker 실습 정리

## 📁 실습 구조 개요

Terraform을 이용하여 로컬 Docker 환경에서 컨테이너를 정의하고, 반복 생성, 환경변수 주입, 볼륨 마운트, 모듈화를 순차적으로 실습한다.

---

## ✅ 실습 ①: 리소스 의존성 (`depends_on`)

### 목적

Terraform에서 명시적으로 리소스 생성 순서를 지정하기 위한 `depends_on` 사용법 실습

### 구성 파일: `main.tf`

```hcl
resource "null_resource" "before" {
  provisioner "local-exec" {
    command = "echo '[1] 먼저 실행할 리소스입니다.' > before.txt"
  }
}

resource "null_resource" "after" {
  depends_on = [null_resource.before]

  provisioner "local-exec" {
    command = "echo '[2] 반드시 위 리소스 이후 실행됩니다.' > after.txt"
  }
}
```

---

## ✅ 실습 ②: `count`를 이용한 반복 생성

### 목적

여러 개의 Docker 컨테이너를 반복 생성하고 포트를 자동 설정

### 파일 구조 및 주요 설정

**variables.tf**

```hcl
variable "container_count" {
  type = number
  default = 3
}

variable "base_port" {
  type = number
  default = 8080
}
```

**terraform.tfvars**

```hcl
container_count = 3
base_port       = 8080
```

**main.tf**

```hcl
provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_containers" {
  count = var.container_count

  name  = "nginx-${count.index + 1}"
  image = docker_image.nginx.latest

  ports {
    internal = 80
    external = var.base_port + count.index
  }
}
```

**outputs.tf**

```hcl
output "container_names" {
  value = [for c in docker_container.nginx_containers : c.name]
}
```

---

## ✅ 실습 ③: 환경변수 주입 (ENV)

### 목적

컨테이너에 환경변수를 주입하여 내부에서 사용할 수 있도록 설정

**variables.tf**

```hcl
variable "container_name" { type = string }
variable "external_port" { type = number }
variable "app_name" { type = string }
variable "app_env" { type = string }
```

**terraform.tfvars**

```hcl
container_name = "nginx-env"
external_port  = 8090
app_name       = "MyNginxApp"
app_env        = "production"
```

**main.tf**

```hcl
provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_container" {
  name  = var.container_name
  image = docker_image.nginx.latest

  ports {
    internal = 80
    external = var.external_port
  }

  env = [
    "MY_APP_NAME=${var.app_name}",
    "MY_ENV=${var.app_env}"
  ]
}
```

---

## ✅ 실습 ④: 볼륨 마운트 (Volume)

### 목적

호스트 디렉토리를 컨테이너 내부로 마운트하여 실시간 HTML 수정 반영

**variables.tf**

```hcl
variable "container_name" { type = string }
variable "external_port" { type = number }
variable "html_host_path" { type = string }
```

**terraform.tfvars**

```hcl
container_name = "nginx-volume"
external_port  = 8088
html_host_path = "/absolute/path/to/nginx-html"
```

**main.tf**

```hcl
provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_volume_container" {
  name  = var.container_name
  image = docker_image.nginx.latest

  ports {
    internal = 80
    external = var.external_port
  }

  volumes {
    host_path      = var.html_host_path
    container_path = "/usr/share/nginx/html"
  }
}
```

---

## ✅ 실습 ⑤: `for_each` 반복 생성

### 목적

서로 다른 설정을 가진 컨테이너를 map 기반으로 반복 생성

**variables.tf**

```hcl
variable "containers" {
  type = map(number)
}
```

**terraform.tfvars**

```hcl
containers = {
  nginx1 = 8081
  nginx2 = 8082
  nginx3 = 8083
}
```

**main.tf**

```hcl
provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_containers" {
  for_each = var.containers

  name  = each.key
  image = docker_image.nginx.latest

  ports {
    internal = 80
    external = each.value
  }
}
```

---

## ✅ 실습 ⑥: 모듈(Module) 활용

### 목적

반복되는 설정을 모듈로 분리하여 구조화하고 재사용성 향상

**디렉토리 구조**

```
modules/
└── nginx_container/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

### 모듈 내부 파일

**main.tf**

```hcl
resource "docker_container" "nginx" {
  name  = var.container_name
  image = var.image_name

  ports {
    internal = 80
    external = var.external_port
  }

  env = ["MY_ENV=${var.app_env}"]
}
```

**variables.tf**

```hcl
variable "container_name" { type = string }
variable "image_name" { type = string }
variable "external_port" { type = number }
variable "app_env" { type = string }
```

### 루트 모듈 파일

**variables.tf**

```hcl
variable "containers" {
  type = map(object({
    port = number
    env  = string
  }))
}
```

**terraform.tfvars**

```hcl
containers = {
  nginx-a = { port = 8081, env = "dev" }
  nginx-b = { port = 8082, env = "staging" }
}
```

**main.tf**

```hcl
provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

module "nginx" {
  for_each = var.containers
  source = "./modules/nginx_container"

  container_name = each.key
  image_name     = docker_image.nginx.latest
  external_port  = each.value.port
  app_env        = each.value.env
}
```

**outputs.tf**

```hcl
output "created_containers" {
  value = [for m in module.nginx : m.container_name]
}
```

---
